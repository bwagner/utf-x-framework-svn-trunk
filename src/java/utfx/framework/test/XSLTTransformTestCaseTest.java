package utfx.framework.test;

import java.io.ByteArrayInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.w3c.dom.Document;

import utfx.framework.XSLTTestFileSuite;
import utfx.framework.XSLTTransformTestCase;

/**
 * This class tests utfx.framework.XSLTTransformTestCase.
 * <p>
 * Copyright &copy; 2004 - 2005 USQ and others.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/XSLTTransformTestCaseTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class XSLTTransformTestCaseTest extends TestCase {

    /** this is where we find our test data */
    private static final String testDir = "src/java/utfx/framework/test/";

    /**
     * The most reliable way of creating a few XSLTTransformTestCase objects for
     * testing is to create a XSLTTestFileSuite from a test definition file and
     * pull out individual XSLT transform test cases. This object is the suite
     * containing our test case objects.
     */
    private XSLTTestFileSuite fileSuite;

    private XSLTTransformTestCase tc1, tc2;

    public XSLTTransformTestCaseTest() throws Exception {
        fileSuite = (XSLTTestFileSuite) XSLTTestFileSuite.suite(testDir
                + "xslt_transform_test_case_test_1.xml");
        tc1 = (XSLTTransformTestCase) fileSuite.testAt(0);

        // second test creates source and expected XML validation test cases
        // which we are not interested. The actual XSLT transform test case
        // follows the two.
        tc2 = (XSLTTransformTestCase) fileSuite.testAt(3);

    }

    public void setUp() throws Exception {
        // nothing to do here
    }

    // using UTFX test case 1

    public void testProcessNode_getFailureMessage1() throws Exception {
        assertEquals(tc1.getFailureMessage(), "this is the failure message");
    }

    public void testProcessNode_validateSource1() throws Exception {
        assertEquals(tc1.validateSource(), false);
    }

    public void testProcessNode_validateExpected1() throws Exception {
        assertEquals(tc1.validateExpected(), false);
    }

    public void testProcessNode_useSourceParser1() throws Exception {
        assertEquals(tc1.useSourceParser(), false);
    }

    // using UTFX test case 2

    public void testProcessNode_getFailureMessage2() throws Exception {
        assertEquals(tc2.getFailureMessage(), "some failure message");
    }

    public void testProcessNode_validateSource2() throws Exception {
        assertEquals(tc2.validateSource(), true);
    }

    public void testProcessNode_validateExpected2() throws Exception {
        assertEquals(tc2.validateExpected(), true);
    }

    public void testProcessNode_useSourceParser2() throws Exception {
        assertEquals(tc2.useSourceParser(), true);
    }

    public void testSerialiseNode() throws Exception {
        // simple test to see if parser breaks afterserialising a DOM with
        // non-ascii chars
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(false);
        Document doc;
        DocumentBuilder db = dbf.newDocumentBuilder();
        String xml = "<root>&#160;</root>";
        doc = db.parse(new ByteArrayInputStream(xml.getBytes("UTF-8")));
        tc2.serializeNode(doc);// only test that no exception is being thrown
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(XSLTTransformTestCaseTest.class);
        return suite;
    }

}
