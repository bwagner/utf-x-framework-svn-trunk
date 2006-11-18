package utfx.printers;

import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Stack;

import utfx.framework.StringComparisonFailure;

import junit.framework.AssertionFailedError;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestFailure;
import junit.framework.TestResult;
import junit.framework.TestSuite;
import junit.runner.BaseTestRunner;

/**
 * TODO doco PLS!
 * 
 * <p>
 * Copyright &copy; 2004 - <a href="http://www.usq.edu.au"> University of
 * Southern Queensland. </a>
 * </p>
 * 
 * <p>
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the <a href="http://www.gnu.org/licenses/gpl.txt">GNU General
 * Public License v2 </a> as published by the Free Software Foundation.
 * </p>
 * 
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * </p>
 * 
 * <code>
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/FormattedResultPrinter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.4 $ $Date: 2006/03/17 23:34:37 $ $Name:  $
 */
public class FormattedResultPrinter extends ResultPrinter {

    int testCount = 0;

    int testDepth = 0;

    int testNameLength = 0;

    boolean passed = true;

    Stack statsStack;
    
    Stack testSuiteNames;

    String testSuiteName;

    boolean reportSuitesOnly = false;

    public FormattedResultPrinter(OutputStream os) {
        super(os);
        statsStack = new Stack();
        testSuiteNames = new Stack();        
    }

    /**
     * Print report header.
     */
    public void printHeader(TestResult result) {
        println();
        println("Time: ");
        printElapsedTimeMillis();
        println(" ms");
    }

    public void printErrors(TestResult result) {
        printDefects(result.errors(), result.errorCount(), "error");
    }

    public void printFailures(TestResult result) {
        printDefects(result.failures(), result.failureCount(), "failure");
    }

    public void printDefects(Enumeration booBoos, int count, String type) {
        if (count == 0) {
            return;
        }
        if (count == 1) {
            println("There was " + count + " " + type + ":");
        } else {
            println("There were " + count + " " + type + "s:");
        }
        for (int i = 1; booBoos.hasMoreElements(); i++) {
            printDefect((TestFailure) booBoos.nextElement(), i);
        }
    }

    // only public for testing purposes
    public void printDefect(TestFailure booBoo, int count) {
        printDefectHeader(booBoo, count);
        // printDefectTrace(booBoo);
    }

    public void printDefectHeader(TestFailure booBoo, int count) {
        String message;
        Throwable err = booBoo.thrownException();
        message = "[" + count + "] " + booBoo.failedTest().toString();
        println(message);
        if (err instanceof StringComparisonFailure) {
            String actual, expected;
            StringComparisonFailure xcf = (StringComparisonFailure) err;
            expected = xcf.getSameContent() + " [ DIFF ] "
                    + xcf.getDiffExpected();
            actual = xcf.getSameContent() + " [ DIFF ] " + xcf.getDiffActual();
            println("actual:");
            println(actual);
            println("expected:");
            println(expected);
        } else {
            // TODO we should print stack trace in a nice colour
        }
    }

    protected void printDefectTrace(TestFailure booBoo) {
        print(BaseTestRunner.getFilteredTrace(booBoo.trace()));
    }

    /**
     * Print report footer.
     */
    public void printFooter(TestResult result) {
        if (result.wasSuccessful()) {
            println();
            print("OK" + " (" + result.runCount() + " test"
                    + (result.runCount() == 1 ? "" : "s") + ")");

        } else {
            println();
            println("FAILURES!!!\n");
            print("Tests run: " + result.runCount());
            if (result.failureCount() > 0) {
                print(", Failures: " + result.failureCount());
            }
            if (result.errorCount() > 0) {
                println(", Errors: " + result.errorCount());
            }
        }
        println();
    }

    /**
     * @see junit.framework.TestListener#addError(Test, Throwable)
     */
    public void addError(Test test, Throwable t) {
        String fqName = t.getClass().getName(); // fully qualified class name
        String name = fqName.substring(fqName.lastIndexOf('.') + 1, fqName
                .length());
        print(" [" + name + ":" + t.getMessage() + "] ");
        passed = false;
    }

    /**
     * @see junit.framework.TestListener#addFailure(Test, AssertionFailedError)
     */
    public void addFailure(Test test, AssertionFailedError t) {
        if (!reportSuitesOnly) {
            print(" [" + t.getMessage() + "]");
        }
        passed = false;
    }

    /**
     * This method is called after all result printing has been completed. It
     * flushes and closes the PrintStream.
     */
    public void close() {
        super.close();
    }

    /**
     * @see junit.framework.TestListener#startTest(Test)
     */
    public void startTestCase(TestCase test) {
        passed = true;

        testCount++;
        print(getIndent(suiteDepth + 1));
        // print the name of the thread running this test
        print("[");

        print(new Integer(testCount).toString());
        print("] ");
        print(testSuiteNames.peek() + ".");
        print(getCleanName(test));
        testDepth++;
    }

    private String getCleanName(Test t) {
        String name = t.toString();

        try {
            name = name.substring(0, name.indexOf("(")) + "()";
        } catch (Exception e) {
            // leave name as it was
        }
        testNameLength = name.length();

        return name;
    }

    /**
     * @see junit.framework.TestListener#endTest(Test)
     */
    public void endTestCase(TestCase test) {
        if (passed) {
            print(" [OK]");
        }
        println();
        testDepth--;
    }

    /**
     * Start of a test suite.
     * 
     * @param suite the TestSuite we are entering.
     */
    public void startTestSuite(TestSuite suite) {
        // for every new test suite we add a stats object, attach it
        // to the result and throw it on the stack
        // TestSuiteStats stats = new TestSuiteStats(suite.getName());

        testSuiteName = suite.getName();
        testSuiteNames.push(testSuiteName);                
        print(getIndent(suiteDepth));
        println("running " + suite.testCount() + " tests/suites in " + "("
                + testSuiteName + ")");
        // statsStack.push(stats);
    }

    /**
     * End of a test suite.
     * 
     * @param suite the test suite we are leaving
     */
    public void endTestSuite(TestSuite suite) {
        testSuiteNames.pop();

        /*
         * TestSuiteStats stats; stats = (TestSuiteStats) statsStack.pop();
         * testSuiteName = stats.suiteName; testNameLength =
         * suite.getName().length();
         * 
         * print(" [" + stats.testCount + " tests, "); if (stats.allTestsPassed) {
         * print(new AnsiString(" ALL PASSED ", AnsiString.GREEN)); } if
         * (stats.errorCount > 0) { print(new AnsiString(stats.errorCount + "
         * Error(s) ", AnsiString.YELLOW)); }
         * 
         * if (stats.failureCount > 0) { print(new AnsiString(stats.failureCount + "
         * Failure(s) ", AnsiString.RED)); }
         * 
         * println();
         */
    }
}