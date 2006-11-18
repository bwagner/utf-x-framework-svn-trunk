package utfx.test;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Full regression test of the UTF-X package.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/test/FullRegressionTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.3.2.5 $ $Date: 2006/10/28 23:20:09 $ $Name:  $
 */
public class FullRegressionTest extends TestCase {

    /**
     * Constructs a test suit with a specified name.
     */
    public FullRegressionTest(String name) {
        super(name);
    }

    /**
     * Assemble and return test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite("UTF-X full regression test.");

        suite.addTest(JavaRegressionTest.suite());
        suite.addTest(SamplesRegressionTest.suite());
        suite.addTest(TestsRegressionTest.suite());

        return suite;
    }
}
