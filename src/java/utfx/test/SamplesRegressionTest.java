package utfx.test;

import utfx.framework.XSLTRegressionTest;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Samples regression test.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/test/Attic/SamplesRegressionTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 67 $ $Date: 2006-11-18 01:40:44 +0100 (Sat, 18 Nov 2006) $ $Name:  $
 */
public class SamplesRegressionTest extends TestCase {

    /**
     * Constructs a test suit with a specified name.
     * 
     * @param name
     *            the name of the test suite.
     */
    public SamplesRegressionTest(String name) {
        super(name);
    }

    /**
     * Assemble and return test suite.
     * 
     * @return assembled test case.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite("UTF-X samples regression test.");

        System.setProperty("utfx.test.dir", "./samples/");

        System.setProperty("javax.xml.transform.TransformerFactory",
                "net.sf.saxon.TransformerFactoryImpl");
        suite.addTest(XSLTRegressionTest.suite());

        return suite;
    }
}
