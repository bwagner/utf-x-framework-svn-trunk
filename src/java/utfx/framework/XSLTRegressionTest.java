package utfx.framework;

import java.io.File;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.apache.log4j.Logger;

/**
 * This class represents a root of the XSLT test suites. Test suite(s) are built
 * recursevly under this test suite to form a full regression test of UTF-X test
 * cases. To specify which tests should form the regression test you may either
 * specify test root directory or specific UTF-X test definition file as
 * properties. If <code>utfx.test.dir</code> property is set then this class
 * will read it's value and use it as the test directory root for the regression
 * test. If the <code>utfx.test.dir</code> property is not specified then the
 * <code>suite()</code> method will attempt to read
 * <code>utfx.test.file</code> system property and use its value as the name
 * of the UTF-X test definition file to run.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/XSLTRegressionTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido
 * @author Sally MacFarlane
 * @version $Revision: 1.3 $ $Date: 2006/02/26 05:10:29 $ $Name:  $
 */
public class XSLTRegressionTest extends TestSuite {

    /** logger */
    private static Logger log = Logger.getLogger("utfx.framework");

    /**
     * Constructs an XSLT test suite with a specified name.
     */
    public XSLTRegressionTest(String name) {
        super(name);
    }

    /**
     * Assemble and return test suite.
     */
    public static Test suite() {

        String testDirName = System.getProperty("utfx.test.dir");
        String testFileName = System.getProperty("utfx.test.file");

        TestSuite suite = new TestSuite("UTF-X test suite: "
                + System.getProperty("javax.xml.transform.TransformerFactory"));

        try {

            if (testDirName != null && !"".equals(testDirName)) {
                suite.addTest(XSLTTestDirectorySuite.suite(testDirName));

            } else if (testFileName != null && !"".equals(testFileName)) {
                File testFile = new File(testFileName);
                suite.addTest(XSLTTestFileSuite.suite(testFile
                        .getAbsolutePath()));
            }
        } catch (Exception e) {
            log.error("Could not create test suite ", e);
        }
        return suite;
    }
}