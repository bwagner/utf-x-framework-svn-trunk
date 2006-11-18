package utfx.printers;

import java.io.OutputStream;
import java.io.PrintStream;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestListener;
import junit.framework.TestResult;
import junit.framework.TestSuite;

import org.apache.log4j.Logger;

import utfx.framework.ConfigurationManager;

/**
 * Abstract result printer. Result printers are used for printing test run
 * results. General idea based on <code>junit.textui.ResultPrinter</code>. In
 * this implementation we allow for different result printers to be attached to
 * the TestResult object and print the results of a test run in various ways.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/ResultPrinter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public abstract class ResultPrinter extends PrintStream implements TestListener {

    /** the depth of the current suite; root test suite = 0 */
    protected int suiteDepth = -1;

    /** total test case conter; first test = 1 */
    protected int testCaseCount = 0;

    /** indent string */
    protected String indentString = "    ";

    /** start time in milliseconds */
    private long startTime;

    /** loggin facility */
    protected Logger log;

    /**
     * Construnct a new Result Printer from an OutputStream.
     */
    public ResultPrinter(OutputStream os) {
        super(os);
        log = Logger.getLogger("utfx.framework");        
    }

    /**
     * @return indent string
     */
    public String getIndent(int depth) {
        StringBuffer indent = new StringBuffer(indentString.length() * depth);

        for (int i = 0; i < depth; i++) {
            indent.append(indentString);
        }
        return indent.toString();
    }

    /**
     * Print the result summary. This method should be called at the end of a
     * test run to produce a regression test summary.
     * 
     * based on <code>junit.textui.ResultPrinter</code>
     * 
     * @param result test result
     */
    public void printSummary(TestResult result) {
        log.debug("calling printHeader() ...");
        printHeader(result);
        log.debug("calling printErrors() ...");
        printErrors(result);
        log.debug("calling printFailures() ...");
        printFailures(result);
        log.debug("calling printFooter() ...");
        printFooter(result);
    }

    /**
     * Print report header. Based on <code>junit.textui.ResultPrinter</code>
     */
    public abstract void printHeader(TestResult result);

    /**
     * Print report header. Based on <code>junit.textui.ResultPrinter</code>
     */
    public abstract void printFooter(TestResult result);

    /**
     * Print errors. Based on <code>junit.textui.ResultPrinter</code>
     * 
     * @param result test result
     */
    public abstract void printErrors(TestResult result);

    /**
     * Print failures. Based on <code>junit.textui.ResultPrinter</code>
     * 
     * @param result test result
     */
    public abstract void printFailures(TestResult result);

    /**
     * Start of a test case.
     * 
     * @param testCase the TestSuite we are entering.
     */
    public abstract void startTestCase(TestCase testCase);

    /**
     * End of a test case.
     * 
     * @param testCase
     */
    public abstract void endTestCase(TestCase testCase);

    /**
     * Start of a test suite.
     * 
     * @param suite the TestSuite we are entering.
     */
    public abstract void startTestSuite(TestSuite suite);

    /**
     * End of a test suite.
     * 
     * @param suite the test suite we are leaving
     */
    public abstract void endTestSuite(TestSuite suite);

    /**
     * Start a test
     */
    public final void startTest(Test test) {
        if (test instanceof TestSuite) {
            suiteDepth++;
            startTestSuite((TestSuite) test);
        } else if (test instanceof TestCase) {
            testCaseCount++;
            startTestCase((TestCase) test);
        }
    }

    /**
     * end a test
     */
    public final void endTest(Test test) {
        if (test instanceof TestSuite) {
            endTestSuite((TestSuite) test);
            suiteDepth--;
        } else if (test instanceof TestCase) {
            endTestCase((TestCase) test);
        }
    }

    /**
     * This method is called before any test runs.
     */
    public void start() {
        startTime = System.currentTimeMillis();
    }

    /**
     * Print the number of milli seconds that elapsed since the start() method
     * was called.
     */
    public void printElapsedTimeMillis() {
        print(System.currentTimeMillis() - startTime);
    }

//    public void print
    
    /**
     * Specific result printers can se the indent string to what ever they like.
     * 
     * @param indentString new indent string. This string will be used as a
     *        single unit of indentation. Indentation = indentString *
     *        suiteDepth.
     */
    protected void setIndentString(String indentString) {
        this.indentString = indentString;
    }

    /**
     *  
     */
    public void printIndent() {
        StringBuffer indent = new StringBuffer(indentString.length()
                * suiteDepth);

        for (int i = 0; i < suiteDepth; i++) {
            indent.append(indentString);
        }
        print(indent);
    }
}