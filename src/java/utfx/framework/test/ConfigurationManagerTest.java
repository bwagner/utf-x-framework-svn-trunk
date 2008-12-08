package utfx.framework.test;

import utfx.framework.ConfigurationManager;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * utfx.framework.ConfigurationManager test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/ConfigurationManagerTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class ConfigurationManagerTest extends TestCase {

    /**
     * Constructs a test with a specified name.
     * 
     * @param name the test name
     */
    public ConfigurationManagerTest(String name) throws Exception {
        super(name);
    }

    /**
     * Test singleton. Call getInstance() twice and make sure that both
     * instances are the same; ie are the same singleton.
     */
    public void testGetInstance() throws Exception {
        ConfigurationManager cm1, cm2;
        cm1 = ConfigurationManager.getInstance();
        cm2 = ConfigurationManager.getInstance();

        assertSame("getInstance() did not return a 'singleton'", cm1, cm2);
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(ConfigurationManagerTest.class);
        return suite;
    }
}