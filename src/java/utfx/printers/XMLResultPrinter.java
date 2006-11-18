package utfx.printers;

import java.io.File;
import java.io.OutputStream;
import java.util.Date;
import java.util.Enumeration;

import junit.framework.AssertionFailedError;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestFailure;
import junit.framework.TestResult;
import junit.framework.TestSuite;
import utfx.framework.StringComparisonFailure;

/**
 * XML Result Printer.
 * <p>
 * Copyright &copy; 2004 - <a href="http://www.usq.edu.au"> University of
 * Southern Queensland. </a>
 * </p>
 * <p>
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the <a href="http://www.gnu.org/licenses/gpl.txt">GNU General
 * Public License v2 </a> as published by the Free Software Foundation.
 * </p>
 * <p>
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * </p>
 * <code>
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/XMLResultPrinter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class XMLResultPrinter extends ResultPrinter {

    int testCounter;

    /**
     * Create a new XML result printer.
     */
    public XMLResultPrinter(OutputStream os) {
        super(os);
    }

    /**
     * Start of the regression test.
     */
    public void start() {
        super.start();
        String testDir = System.getProperty("utfx.test.dir");
        String testFile = System.getProperty("utfx.test.file");
        println("<regression-test>");
        println("<date>" + new Date() + "</date>");
        if (testDir != null) {
            println("<test-dir>" + new File(testDir).getAbsolutePath()
                    + "</test-dir>");
        } else if (testFile != null) {
            println("<test-file>" + new File(testFile).getAbsolutePath()
                    + "</test-file>");
        }
    }

    /**
     * This method is called after all result printing has been completed. It
     * flushes and closes the PrintStream.
     */
    public void close() {
        println("</regression-test>");
    }

    /**
     * Print the result summary. This method should be called at the end of a
     * test run to produce a regression test report.
     * 
     * @param result
     *            test result
     */
    public void printSummary(TestResult result) {
        print(getIndent(1) + "<test-summary>");
        printHeader(result);
        printErrors(result);
        printFailures(result);
        printFooter(result);
        print(getIndent(1) + "</test-summary>");
    }

    /**
     * Print summary header. The summary contains the following information: run
     * time, run count, error count and failure count.
     */
    public void printHeader(TestResult result) {

        println("<test-summary-header>");
        print("<run-time>");
        printElapsedTimeMillis();
        print("</run-time>");
        println("<run-count>" + result.runCount() + "</run-count>");
        println("<error-count>" + result.errorCount() + "</error-count>");
        println("<failure-count>" + result.failureCount() + "</failure-count>");
        println("</test-summary-header>");
    }

    /**
     * End of the regression test.
     */
    public void printFooter(TestResult result) {
        flush();
    }

    /**
     * Print a list of tests that failed. If no tests failed then do not print
     * anything.
     * 
     * @param result
     *            result of the test
     */
    public void printFailures(TestResult result) {
        Enumeration failures = result.failures();
        TestFailure failure;
        Throwable t;
        String message;

        if (result.failureCount() == 0) {
            return;
        }

        println("<test-failures>");

        for (int f = 1; failures.hasMoreElements(); f++) {
            failure = (TestFailure) failures.nextElement();
            t = failure.thrownException();
            message = failure.exceptionMessage();

            print("<test-failure count='" + f + "'>");
            println("<test-name><![CDATA[" + failure.failedTest()
                    + "]]></test-name>");
            if (message != null) {
                println("<message>" + message + "</message>");
            }
            if (t != null) {
                println("<stack-trace><![CDATA[");
                t.printStackTrace(this);
                println("]]></stack-trace>");
                if (t instanceof StringComparisonFailure) {
                    println("<string-comparison-failure>");
                    StringComparisonFailure scf = (StringComparisonFailure) t;
                    println("<same-content><![CDATA[" + scf.getSameContent()
                            + "]]></same-content>");
                    println("<diff-expected><![CDATA[" + scf.getDiffExpected()
                            + "]]></diff-expected>");
                    println("<diff-actual><![CDATA[" + scf.getDiffActual()
                            + "]]></diff-actual>");
                    println("</string-comparison-failure>");
                }
            }
            print("</test-failure>");
        }

        println("</test-failures>");
    }

    /**
     * Print the errors. If no tests failed then do not print anything.
     * 
     * @param result
     *            result of the test
     */
    public void printErrors(TestResult result) {
        Enumeration errors = result.errors();
        TestFailure error;
        Throwable t;
        String message;

        if (result.errorCount() == 0) {
            return;
        }

        println("<test-errors>");

        for (int e = 1; errors.hasMoreElements(); e++) {
            error = (TestFailure) errors.nextElement();
            t = error.thrownException();
            message = error.exceptionMessage();

            print("<test-error count='" + e + "'>");
            println("<test-name><![CDATA[" + error.failedTest()
                    + "]]></test-name>");
            if (message != null) {
                println("<message><![CDATA[" + message + "]]></message>");
            }
            if (t != null) {
                println("<stack-trace><![CDATA[");
                t.printStackTrace(this);
                println("]]></stack-trace>");
            }
            print("</test-error>");
        }

        println("</test-errors>");
    }

    /**
     * Nothing to do here. Generate report after all tests complete
     */
    public void addError(Test test, Throwable t) {
        // Nothing to do here. Generate report after all tests complete
        println("<error><![CDATA[" + t.getMessage() + "]]></error>");
    }

    /**
     * Nothing to do here. Generate report after all tests complete
     */
    public void addFailure(Test test, AssertionFailedError t) {
        // Nothing to do here. Generate report after all tests complete
        println("<failure><![CDATA[" + t.getMessage() + "]]></failure>");
    }

    /**
     * @see junit.framework.TestListener#startTest(Test)
     */
    public void startTestCase(TestCase testCase) {
        println(getIndent(suiteDepth + 1) + "<test count=\"" + ++testCounter
                + "\">");
        println(getIndent(suiteDepth + 2) + "<test-name><![CDATA[" + testCase
                + "]]></test-name>");
    }

    /**
     * @see junit.framework.TestListener#endTest(Test)
     */
    public void endTestCase(TestCase testCase) {
        println(getIndent(suiteDepth + 1) + "</test>");
    }

    /**
     * Start of a test suite.
     * 
     * @param suite
     *            the TestSuite we are entering.
     */
    public void startTestSuite(TestSuite suite) {
        println(getIndent(suiteDepth) + "<test-suite>");
        println(getIndent(suiteDepth + 1) + "<suite-name>" + suite.getName()
                + "</suite-name>");
        println(getIndent(suiteDepth + 1) + "<test-count>" + suite.testCount()
                + "</test-count>");
    }

    /**
     * End of a test suite.
     * 
     * @param suite
     *            the test suite we are leaving
     */
    public void endTestSuite(TestSuite suite) {
        println(getIndent(suiteDepth) + "</test-suite>");
    }

}