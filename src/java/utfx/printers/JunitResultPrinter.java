package utfx.printers;

import java.io.OutputStream;
import java.util.Enumeration;

import junit.framework.*;
import junit.runner.BaseTestRunner;

/**
 * Simple result printer which produces output similar to that of
 * <code>junit.textui.ResultPrinter</code>. This result printer is based on
 * <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich Gamma.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/JunitResultPrinter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Kent Beck and Erich Gamma (authors of
 *         <code>junit.textui.ResultPrinter</code>)
 * @version $Revision: 1.2 $ $Date: 2006/03/17 23:34:36 $ $Name:  $
 */
public class JunitResultPrinter extends ResultPrinter {

    /** column number */
    private int colNum = 0;

    public JunitResultPrinter(OutputStream os) {
        super(os);
    }

    /**
     * Print summary header.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printHeader(TestResult result) {
        println();
        print("Time: ");
        printElapsedTimeMillis();
        println();
    }

    /**
     * Print errors.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printErrors(TestResult result) {
        printDefects(result.errors(), result.errorCount(), "error");
    }

    /**
     * Print failures
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printFailures(TestResult result) {
        printDefects(result.failures(), result.failureCount(), "failure");
    }

    /**
     * Print defects.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
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

    /**
     * Print a defect.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printDefect(TestFailure booBoo, int count) {
        printDefectHeader(booBoo, count);
        printDefectTrace(booBoo);
    }

    /**
     * Print defect header.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printDefectHeader(TestFailure booBoo, int count) {
        print("[" + count + "] " + booBoo.failedTest());
    }

    /**
     * Print defect trace.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printDefectTrace(TestFailure booBoo) {
        print(BaseTestRunner.getFilteredTrace(booBoo.trace()));
    }

    /**
     * Print footer.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     */
    public void printFooter(TestResult result) {
        if (result.wasSuccessful()) {
            println();
            print("OK");
            println(" (" + result.runCount() + " test"
                    + (result.runCount() == 1 ? "" : "s") + ")");
        } else {
            println();
            println("FAILURES!!!");
            println("Tests run: " + result.runCount() + ",  Failures: "
                    + result.failureCount() + ",  Errors: "
                    + result.errorCount());
        }
        println();
    }

    /**
     * Print error symbol.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     * @see junit.framework.TestListener#addError(Test, Throwable)
     */
    public void addError(Test test, Throwable t) {
        print('E');
    }

    /**
     * Print failure symbol.
     * 
     * Based on <code>junit.textui.ResultPrinter</code> by Kent Beck and Erich
     * Gamma.
     * 
     * @see junit.textui.ResultPrinter
     * @see junit.framework.TestListener#addFailure(Test, AssertionFailedError)
     */
    public void addFailure(Test test, AssertionFailedError t) {
        print('F');
    }

    /**
     * Start of a test case.
     * 
     * @param testCase the TestSuite we are entering.
     */
    public void startTestCase(TestCase testCase) {
        print('.');

        // just like the original Junit printer we only print up to 40
        // columns wide
        if (colNum++ >= 40) {
            println();
            colNum = 0;
        }
    }

    /**
     * End of a test case.
     * 
     * @param testCase
     */
    public void endTestCase(TestCase testCase) {
        // nothing to do here
    }

    /**
     * Start of a test suite.
     * 
     * @param suite the TestSuite we are entering.
     */
    public void startTestSuite(TestSuite suite) {
        // nothing to do here
    }

    /**
     * End of a test suite.
     * 
     * @param suite the TestSuite we are leaving
     */
    public void endTestSuite(TestSuite suite) {
        // nothing to do here
    }

}