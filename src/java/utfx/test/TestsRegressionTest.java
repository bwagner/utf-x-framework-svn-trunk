package utfx.test;

import utfx.framework.XSLTRegressionTest;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * UTF-X tests regression test. This is a regression test of tests found in the
 * test directory.
 * <p>
 * Copyright &copy; 2006 - UTF-X Development Team
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/test/Attic/TestsRegressionTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class TestsRegressionTest extends TestCase {

    /**
     * Constructs a test suit with a specified name.
     * 
     * @param name
     *            the name of the test suite.
     */
    public TestsRegressionTest(String name) {
        super(name);
    }

    /**
     * Assemble and return test suite.
     * 
     * @return assembled test case.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite("UTF-X test regression test.");

        System.setProperty("utfx.test.dir", "tests/good/xslt_1_0");

        System.setProperty("javax.xml.transform.TransformerFactory",
                "com.sun.org.apache.xalan.internal."
                        + "xsltc.trax.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        System.setProperty("javax.xml.transform.TransformerFactory",
                "org.apache.xalan.xsltc.trax.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        System.setProperty("javax.xml.transform.TransformerFactory",
                "net.sf.saxon.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        System.setProperty("javax.xml.transform.TransformerFactory",
                "org.apache.xalan.processor.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        // tests that require xslt 2.0 processor are only ran with Saxon
        System.setProperty("utfx.test.dir", "tests/good/xslt_2_0");

        System.setProperty("javax.xml.transform.TransformerFactory",
                "net.sf.saxon.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        return suite;
    }
}
