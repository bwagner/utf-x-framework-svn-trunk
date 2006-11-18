package utfx.framework.test;

import java.io.ByteArrayInputStream;

import utfx.framework.UTFXTestCase;
import utfx.framework.StringComparisonFailure;

import junit.framework.AssertionFailedError;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * UTFXTestCase test.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/UTFXTestCaseTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2 $ $Date: 2005/03/16 05:28:13 $ $Name:  $
 */
public class UTFXTestCaseTest extends TestCase {

    /** test case object used for testing */
    private UTFXTestCase tc;

    public void setUp() {
        tc = new UTFXTestCase("UTF-X test case");
    }

    /**
     * Test assert equals on two byte arrays that are the same.
     */
    public void testAssertEqualsbyteArraybyteArray1() throws Exception {
        byte[] b1 = { 'a', 'b', 'c', 'd' };
        byte[] b2 = { 'a', 'b', 'c', 'd' };

        tc.assertEquals(b1, b2);
    }

    /**
     * Test assert equals on two byte arrays that are different.
     */
    public void testAssertEqualsbyteArraybyteArray2() throws Exception {
        byte[] b1 = { 'a', 'b', 'c', 'd' };
        byte[] b2 = { 'a', 'b', 'c', 'a' };

        try {
            tc.assertEquals(b1, b2);
            fail("arrays differ and AssertionFailedError "
                    + "should have benn thrown");
        } catch (StringComparisonFailure xcf) {
            assertEquals("getSameContent() failed", "abc", xcf.getSameContent());
            assertEquals("getDiffExpected() failed", "d", xcf.getDiffExpected());
            assertEquals("getDiffActual() failed", "a", xcf.getDiffActual());
        }
    }

    /**
     * Test assert equals on two byte arrays that are of different length.
     */
    public void testAssertEqualsbyteArraybyteArray3() throws Exception {
        byte[] b1 = { 'a', 'b', 'c', 'd' };
        byte[] b2 = { 'a', 'b', 'c', 'd', 'e' };

        try {
            tc.assertEquals(b1, b2);
            fail("(b1, b2) arrays differ and AssertionFailedError "
                    + "should have benn thrown");
        } catch (AssertionFailedError afe) {
            // test passed
        }

        try {
            tc.assertEquals(b2, b1);
            fail("(b2, b1) arrays differ and AssertionFailedError "
                    + "should have benn thrown");
        } catch (AssertionFailedError afe) {
            // test passed
        }
    }

    /**
     * test assert equals on two input streams that are the same.
     */
    public void testAssertEqualInputStreams1() throws Exception {
        String s1 = "<doc><e1>content</e1></doc>";
        String s2 = "<doc><e1>content</e1></doc>";
        ByteArrayInputStream bais1 = new ByteArrayInputStream(s1.getBytes());
        ByteArrayInputStream bais2 = new ByteArrayInputStream(s2.getBytes());

        tc.assertEquals(bais1, bais2);
    }

    /**
     * test assert equals on two input streams that are NOT the same.
     */
    public void testAssertEqualInputStreams2() throws Exception {
        String s1 = "<doc><e2>content</e2></doc>";
        String s2 = "<doc><e1>content</e1></doc>";
        ByteArrayInputStream bais1 = new ByteArrayInputStream(s1.getBytes());
        ByteArrayInputStream bais2 = new ByteArrayInputStream(s2.getBytes());

        try {
            tc.assertEquals(bais1, bais2);
            fail("input streams differ hence AssertionFailedError should "
                    + "have been thrown");
        } catch (AssertionFailedError afe) {
            // test passed
        }
    }

    /**
     * Class under test for void assertEquivXML(String, InputStream,
     * InputStream)
     */
    public void testAssertEquivXMLStringInputStreamInputStream()
            throws Exception {
        String s1 = "<doc> <e1>content</e1> </doc>";
        String s2 = "<doc><e1>content</e1></doc>";
        ByteArrayInputStream bais1 = new ByteArrayInputStream(s1.getBytes());
        ByteArrayInputStream bais2 = new ByteArrayInputStream(s2.getBytes());

        tc.assertEquivXML("failed", bais1, bais2);
    }

    /**
     * Class under test for void assertEquivXML(String, String)
     */
    public void testAssertEquivXMLStringString() throws Exception {
        String s1 = "<doc> <e1>content</e1> </doc>";
        String s2 = "<doc><e1>content</e1></doc>";

        tc.assertEquivXML(s1, s2);
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(UTFXTestCaseTest.class);
        return suite;
    }

}
