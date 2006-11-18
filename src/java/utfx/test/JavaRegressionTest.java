package utfx.test;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Regression test of UTF-X Java classes.
 * <p>
 * Copyright &copy; 2006 - UTF-X Developeam Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/test/Attic/JavaRegressionTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class JavaRegressionTest extends TestCase {

    /**
     * Constructs a test suit with a specified name.
     * 
     * @param name the name of the test suite.
     */
    public JavaRegressionTest(String name) {
        super(name);
    }

    /**
     * Assemble and return test suite.
     * 
     * @return assembled test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite("UTF-X Java classes regression test.");

        suite.addTest(utfx.framework.test.PackageTestSuite.suite());
        suite.addTest(utfx.samples.test.PackageTestSuite.suite());
        suite.addTest(utfx.util.test.PackageTestSuite.suite());
        suite.addTest(utfx.testgen.test.PackageTestSuite.suite());

        return suite;
    }
}
