package utfx.runner;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Enumeration;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestResult;
import junit.framework.TestSuite;
import junit.runner.BaseTestRunner;
import junit.runner.StandardTestSuiteLoader;
import junit.runner.TestSuiteLoader;
import junit.runner.Version;

import org.apache.log4j.Logger;

import utfx.framework.ConfigurationManager;
import utfx.printers.ResultLogger;
import utfx.printers.ResultPrinter;
import utfx.printers.ResultPrinterFactory;
import utfx.printers.XMLResultPrinter;

/**
 * UTF-X TestRunner. This code is based on the original
 * <code>junit.textui.TestRunner</code> class written by Kent Beck and Erich
 * Gamma.
 * FIXME rewrite me please
 * <p>
 * Copyright &copy; 2004-2005 <a href="http://www.usq.edu.au"> University of
 * Southern Queensland and others. </a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/runner/TestRunner.java,v $
 * </code>
 * 
 * @author Kent Beck (original author)
 * @author Erich Gamma (original author)
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class TestRunner extends BaseTestRunner {

    /** result printer factory */
    ResultPrinterFactory rpf;

    /** logger */
    private Logger log;

    private ConfigurationManager cm;

    public static final int SUCCESS_EXIT = 0;

    public static final int FAILURE_EXIT = 1;

    public static final int EXCEPTION_EXIT = 2;

    /**
     * Construct a new UTF-X test runner object.
     */
    public TestRunner() {
        super();
        log = Logger.getLogger("utfx.framework");
        cm = ConfigurationManager.getInstance();
    }

    /**
     * Runs a single test and collects its results. This method can be used to
     * start a test run from your program.
     */
    static public TestResult run(Test test, ResultPrinterFactory rpf) {
        TestRunner runner = new TestRunner();
        return runner.doRun(test, rpf);
    }

    /**
     * Always use the StandardTestSuiteLoader. Overridden from BaseTestRunner.
     */
    public TestSuiteLoader getLoader() {
        return new StandardTestSuiteLoader();
    }

    public void testFailed(int status, Test test, Throwable t) {
        log.debug("testFailed() called");
    }

    public void testStarted(String testName) {
        log.debug("testStarted() called");
    }

    public void testEnded(String testName) {
        log.debug("testEnded() called");
    }

    protected TestResult createTestResult() {
        return new TestResult();
    }

    /**
     * This is where we run the tests.
     * 
     * @param suite
     *            suite of tests to run
     */
    public TestResult doRun(Test suite, ResultPrinterFactory rpf) {
        TestResult result = new TestResult();
        ResultPrinter rp = rpf.newResultPrinter();
        ResultLogger rl = new ResultLogger();
        XMLResultPrinter xrp = null;
        ByteArrayOutputStream baos = null;
        FileOutputStream fos = null;
        FileInputStream fis;
        ResultPrinter[] printers;
        rp.start();

        if (cm.generateHTMLReport()) {
            printers = new ResultPrinter[2];
            baos = new ByteArrayOutputStream(0x1000);
            // FIXME this code by passes the factory
            xrp = new XMLResultPrinter(baos);
            xrp.start();
            printers[1] = xrp;
            result.addListener(xrp);
        } else {
            printers = new ResultPrinter[1];
        }

        printers[0] = rp;
        result.addListener(rp);
        result.addListener(rl);
        runTest(suite, result, printers);
        rp.printSummary(result);
        rp.close();

        if (cm.generateHTMLReport()) {
            xrp.printSummary(result);
            xrp.close();
            try {
                generateReport(new ByteArrayInputStream(baos.toByteArray()));
            } catch (Exception e) {
                log.error("failed creating HTML report", e);
            }
            if (cm.openHTMLReportInBrowser()) {
                displayReport();
            }
        }

        return result;
    }

    private void generateReport(InputStream xmlIs) throws Exception {
        TransformerFactory tf;
        Transformer t;
        StreamSource xmlReport;
        StreamResult htmlReport;
        InputStream xsltIs;
        FileOutputStream fos;

        xsltIs = ClassLoader
                .getSystemResourceAsStream("xsl/test_results_xhtml.xsl");
        tf = TransformerFactory.newInstance();
        t = tf.newTransformer(new StreamSource(xsltIs));
        xmlReport = new StreamSource(xmlIs);
        fos = new FileOutputStream(cm.getHTMLReportFilename());
        htmlReport = new StreamResult(fos);
        t.transform(xmlReport, htmlReport);
        fos.close();
    }

    /**
     * Attempt to open the report in a browser.
     * 
     */
    private void displayReport() {
        String reportFilename = new File(cm.getHTMLReportFilename())
                .getAbsolutePath();
        Process p;
        Runtime r = Runtime.getRuntime();
        if (System.getProperty("os.name").startsWith("Windows")) {
            try {
                log.debug("Attempting to open Windows browser");
                p = r.exec("rundll32 url.dll,FileProtocolHandler "
                        + reportFilename);
            } catch (Exception e) {
                // ignore
            }
        } else if (System.getProperty("os.name").startsWith("Mac OS X")) {
            try {
                log.debug("Attempting to open Mac OS X browser");
                p = r.exec("open " + reportFilename);
            } catch (Exception e) {
                // ignore
            }            
        } else {
            try {
                log.debug("Attempting to open firefox browser");
                p = r.exec("firefox " + reportFilename);
            } catch (Exception e) {
                try {
                    log.debug("Attempting to open mozilla browser");
                    p = r.exec("mozilla " + reportFilename);
                } catch (Exception ex) {
                    // ignore
                }
            }
        }
    }

    /**
     * Run an individual test case.
     */
    private void runTestCase(TestCase testCase, TestResult result) {
        testCase.run(result);
    }

    /**
     * Run a test of unspecified type (class)
     */
    private void runTest(Test test, TestResult result, ResultPrinter[] rp) {
        if (test instanceof TestSuite) {
            runSuite((TestSuite) test, result, rp);
        } else {
            runTestCase((TestCase) test, result);
        }
    }

    /**
     * Run a test suite
     */
    private void runSuite(TestSuite suite, TestResult result, ResultPrinter[] rp) {
        Enumeration tests = suite.tests();
        Test t;
        for (ResultPrinter p : rp) {
            p.startTest(suite);
        }
        while (tests.hasMoreElements()) {
            t = (Test) tests.nextElement();
            runTest(t, result, rp);
        }
        for (ResultPrinter p : rp) {
            p.endTest(suite);
        }
    }

    /**
     * Starts a test run. This is top level method called on an instance of this
     * class. Analyzes the command line arguments and runs the given test suite.
     * 
     * @param args
     *            array of comman line argument; same as the arguments passed to
     *            main().
     * 
     * @return result of the regression test.
     */
    protected TestResult start(String args[]) throws Exception {
        String testCase = "";

        for (int i = 0; i < args.length; i++) {
            if (args[i].equals("-c")) {
                testCase = extractClassName(args[++i]);
            } else if (args[i].equals("-v")) {
                System.err.println("JUnit " + Version.id()
                        + " by Kent Beck and Erich Gamma\n"
                        + "extension by Software Development Team, "
                        + "DeC, USQ.");
            } else if (args[i].equals("-t")) {
                // support fo threading has been removed
                // numThreads = Integer.parseInt(args[++i]);

            } else if ("-out".equals(args[i])) {
                // reportFileName = args[++i];
            } else { // test case class must be last
                testCase = args[i];
            }
        }

        if (testCase.equals("")) {
            throw new Exception("Usage: TestRunner testCaseName, "
                    + "where name is the name of the TestCase class");
        }
        rpf = ResultPrinterFactory.newInstance();

        try {
            Test suite = getTest(testCase);
            return doRun(suite, rpf);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Could not create and run test suite: " + e);
        }
    }

    protected void runFailed(String message) {
        System.err.println(message);
        System.exit(FAILURE_EXIT);
    }

    /**
     * Main method
     */
    public static void main(String args[]) {
        TestRunner testRunner = new TestRunner();

        try {

            TestResult r = testRunner.start(args);
            if (!r.wasSuccessful()) {
                System.exit(FAILURE_EXIT);
            }
            System.exit(SUCCESS_EXIT);
        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.exit(EXCEPTION_EXIT);
        }
    }

}