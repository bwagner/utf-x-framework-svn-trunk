package utfx.framework.test;

import java.io.ByteArrayInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.w3c.dom.Document;

import utfx.framework.UTFXTestCase;
import utfx.framework.XSLTTestFileSuite;
import utfx.framework.XSLTTransformTestCase;
import utfx.util.SourceSerializer;

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
 * @author Alex Daniel
 * @version $Revision$ $Date$ $Name:  $
 */
public class XSLTTransformTestCaseTest extends UTFXTestCase {

    /** this is where we find our test data */
    private static final String testDir = "src/java/utfx/framework/test/";

    /** for serializing javax.xml.transform.Source to String */ 
    private SourceSerializer sourceSerializer;
    
    /**
     * The most reliable way of creating a few XSLTTransformTestCase objects for
     * testing is to create a XSLTTestFileSuite from a test definition file and
     * pull out individual XSLT transform test cases. This object is the suite
     * containing our test case objects.
     */
    private XSLTTestFileSuite fileSuite;

    private XSLTTransformTestCase tc1, tc2, tc3;
    
    // Commented out because an test with an absolute path can't be executed on another environment
    // private XSLTTransformTestCase tc4;

    public XSLTTransformTestCaseTest() throws Exception {
        super("XSLTTransformTestCaseTest");
        
        fileSuite = (XSLTTestFileSuite) XSLTTestFileSuite.suite(testDir
                + "xslt_transform_test_case_test_1.xml");
        tc1 = (XSLTTransformTestCase) fileSuite.testAt(0);

        // second test creates source and expected XML validation test cases
        // which we are not interested. The actual XSLT transform test case
        // follows the two.
        tc2 = (XSLTTransformTestCase) fileSuite.testAt(3);

        // third test case has no XML validation test cases
        tc3 = (XSLTTransformTestCase) fileSuite.testAt(4);

        // Commented out because an test with an absolute path can't be executed on another environment
        // fourth test case has no XML validation test cases
        // tc4 = (XSLTTransformTestCase) fileSuite.testAt(5);

        sourceSerializer = new SourceSerializer();
    }

    public void setUp() throws Exception {
        // nothing to do here
    }

        
    // using UTFX test case 1
    
    public void testProcessNode_getFailureMessage1() throws Exception {
        assertEquals("this is the failure message", tc1.getFailureMessage());
    }

    public void testProcessNode_validateSource1() throws Exception {
        assertEquals(false, tc1.validateSource());
    }

    public void testProcessNode_validateExpected1() throws Exception {
        assertEquals(false, tc1.validateExpected());
    }

    public void testProcessNode_useSourceParser1() throws Exception {
        assertEquals(false, tc1.useSourceParser());
    }
    
    public void testProcessNode_getExternalSourceFile1() {
        try {
            tc1.getExternalSourceFile();
            fail("expected AssertionError");
        } catch (AssertionError e) {
            // expected AssertionError occured
        }
    }

    public void testGetExternalSourcePath1() {
        try {
            tc1.getExternalSourcePath();
            fail("expected AssertionError");
        } catch (AssertionError e) {
            // expected AssertionError occured
        }
    }
    
    public void testProcessNode_useExternalSourceFile1() {
        assertFalse(tc1.useExternalSourceFile());
    }
    
    public void testProcessNode_transformSource1() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <source-child>some content</source-child>" +
            "</utfx-wrapper>"; 
        String actualXml = sourceSerializer.serialize(tc1.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }
    
    public void testIsAbsolutePathFalse1() {
        assertFalse(tc1.isAbsolutePath("utfx"));
    }
    
    public void testIsAbsolutePathTrue1() {
        assertTrue(tc1.isAbsolutePath("/tmp/utfx"));
    }
    
        
    // using UTFX test case 2

    public void testProcessNode_getFailureMessage2() throws Exception {
        assertEquals("some failure message", tc2.getFailureMessage());
    }

    public void testProcessNode_validateSource2() throws Exception {
        assertEquals(true, tc2.validateSource());
    }

    public void testProcessNode_validateExpected2() throws Exception {
        assertEquals(true, tc2.validateExpected());
    }

    public void testProcessNode_useSourceParser2() throws Exception {
        assertEquals(true, tc2.useSourceParser());
    }

    public void testProcessNode_getExternalSourceFile2() {
        try {
            tc2.getExternalSourceFile();
            fail("expected AssertionError");
        } catch (AssertionError e) {
            // expected AssertionError occured
        }
    }

    public void testGetExternalSourcePath2() {
        try {
            tc2.getExternalSourcePath();
            fail("expected AssertionError");
        } catch (AssertionError e) {
            // expected AssertionError occured
        }
    }

    public void testProcessNode_useExternalSourceFile2() {
        assertFalse(tc2.useExternalSourceFile());
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

    public void testProcessNode_transformSource2() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <source-root>" +
            "    <source-child>child</source-child>" +
            "  </source-root>" + 
            "</utfx-wrapper>";
        String actualXml = sourceSerializer.serialize(tc2.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }

    
    // using UTFX test case 3

    public void testProcessNode_getFailureMessage3() throws Exception {
        assertEquals("UTF-X test failed", tc3.getFailureMessage());
    }

    public void testProcessNode_validateSource3() throws Exception {
        assertEquals(false, tc3.validateSource());
    }

    public void testProcessNode_validateExpected3() throws Exception {
        assertEquals(false, tc3.validateExpected());
    }

    public void testProcessNode_useSourceParser3() throws Exception {
        assertEquals(false, tc3.useSourceParser());
    }

    public void testProcessNode_getExternalSourceFile3() {
        assertEquals("xslt_transform_test_case_test_1_input.xml", tc3.getExternalSourceFile());
    }

    public void testGetExternalSourcePath3() {
        assertEquals(testDir + "xslt_transform_test_case_test_1_input.xml", tc3.getExternalSourcePath());
    }

    public void testProcessNode_useExternalSourceFile3() {
        assertTrue(tc3.useExternalSourceFile());
    }

    public void testProcessNode_transformSource3() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
            "    <content>" +
            "      <para>Using an external file for utfx:source in a TDF</para>" +
            "    </content>" +
            "  </file>" +
            "</utfx-wrapper>";
        String actualXml = sourceSerializer.serialize(tc3.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }

    
    // Commented out because an test with an absolute path can't be executed on another environment
    // using UTFX test case 4
    //    
    //    public void testProcessNode_getFailureMessage4() throws Exception {
    //        assertEquals("UTF-X test failed", tc4.getFailureMessage());
    //    }
    //
    //    public void testProcessNode_validateSource4() throws Exception {
    //        assertEquals(false, tc4.validateSource());
    //    }
    //
    //    public void testProcessNode_validateExpected4() throws Exception {
    //        assertEquals(false, tc4.validateExpected());
    //    }
    //
    //    public void testProcessNode_useSourceParser4() throws Exception {
    //        assertEquals(false, tc4.useSourceParser());
    //    }
    //
    //    public void testProcessNode_getExternalSourceFile4() {
    //        assertEquals("/Users/alex/src/workspace/utf-x-framework/src/java/utfx/framework/test/xslt_transform_test_case_test_1_input.xml", tc4.getExternalSourceFile());
    //    }
    //
    //    public void testGetExternalSourcePath4() {
    //        assertEquals("/Users/alex/src/workspace/utf-x-framework/src/java/utfx/framework/test/xslt_transform_test_case_test_1_input.xml", tc4.getExternalSourcePath());
    //    }
    //
    //    public void testProcessNode_useExternalSourceFile4() {
    //        assertTrue(tc4.useExternalSourceFile());
    //    }
    //
    //    public void testProcessNode_transformSource4() throws Exception {
    //        String expectedXml = 
    //            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
    //            "<utfx-wrapper>" + 
    //            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
    //            "    <content>" +
    //            "      <para>Using an external file for utfx:source in a TDF</para>" +
    //            "    </content>" +
    //            "  </file>" +
    //            "</utfx-wrapper>";
    //        String actualXml = sourceSerializer.serialize(tc4.getTransformSource()); 
    //        assertEquivXML(expectedXml, actualXml);
    //    }

    
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
