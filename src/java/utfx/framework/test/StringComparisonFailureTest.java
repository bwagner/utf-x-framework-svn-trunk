package utfx.framework.test;

import utfx.framework.StringComparisonFailure;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Tests StringComparisonFailure.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/StringComparisonFailureTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2005/03/09 03:53:06 $ $Name:  $
 */
public class StringComparisonFailureTest extends TestCase {

    /** both expected and actual strings are the same length */
    private StringComparisonFailure xcf1;

    /** expected shorted than actual */
    private StringComparisonFailure xcf2;

    /** expected longer than actual */
    private StringComparisonFailure xcf3;

    public void setUp() {
        xcf1 = new StringComparisonFailure("m", "1234567890", "1234560987");
        xcf2 = new StringComparisonFailure("m", "12345678", "1234567890");
        xcf3 = new StringComparisonFailure("m", "1234567890", "1234");
    }

    // XCF1 tests
    public void testXCF1getDiffActual() {
        assertEquals("0987", xcf1.getDiffActual());
    }

    public void testXCF1etDiffExpected() {
        assertEquals("7890", xcf1.getDiffExpected());
    }

    public void testXCF1getSameContent() {
        assertEquals("123456", xcf1.getSameContent());
    }

    // XCF2 tests
    public void testXCF2getDiffActual() {
        assertEquals("90", xcf2.getDiffActual());
    }

    public void testXCF2etDiffExpected() {
        assertEquals("", xcf2.getDiffExpected());
    }

    public void testXCF2getSameContent() {
        assertEquals("12345678", xcf2.getSameContent());
    }
    
    // XCF3 tests
    public void testXCF3getDiffActual() {
        assertEquals("", xcf3.getDiffActual());
    }

    public void testXCF3etDiffExpected() {
        assertEquals("567890", xcf3.getDiffExpected());
    }

    public void testXCF3getSameContent() {
        assertEquals("1234", xcf3.getSameContent());
    }    

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(StringComparisonFailureTest.class);
        return suite;
    }

}
