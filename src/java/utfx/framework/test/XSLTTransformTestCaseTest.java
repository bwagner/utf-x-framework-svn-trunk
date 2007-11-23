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

    private XSLTTransformTestCase tc1, tc2, tcSourceWithHref, tcExpectedWithHref;
    
    // Commented out because an test with an absolute external path can't be executed on another environment
    // private XSLTTransformTestCase tcSourceWithHrefAbsolute;

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
        tcSourceWithHref = (XSLTTransformTestCase) fileSuite.testAt(4);

        // third test case has no XML validation test cases
        tcExpectedWithHref = (XSLTTransformTestCase) fileSuite.testAt(5);
        
        // Commented out because an test with an absolute external path can't be executed on another environment
        // fifth test case has no XML validation test cases
        // tcSourceWithHrefAbsolute = (XSLTTransformTestCase) fileSuite.testAt(6);

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
    
    public void testProcessNode_transformSource1() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <source-child>some content</source-child>" +
            "</utfx-wrapper>"; 
        String actualXml = sourceSerializer.serialize(tc1.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }
    
    public void testGetExpectedString1() throws Exception {
        String expectedXml =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <expected-child>some content</expected-child>" +
            "</utfx-wrapper>"; 
        String actualXml = tc1.getExpectedString();
        assertEquivXML(expectedXml, actualXml);
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

    public void testGetExpectedString2() throws Exception {
        String expectedXml =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <expected-root>" +
            "    <expected-child>child</expected-child>" +
            "  </expected-root>" +
            "</utfx-wrapper>"; 
        String actualXml = tc2.getExpectedString();
        assertEquivXML(expectedXml, actualXml);
    }

    
    // using UTFX test case 3

    public void testProcessNode_getFailureMessage3() throws Exception {
        assertEquals("UTF-X test failed", tcSourceWithHref.getFailureMessage());
    }

    public void testProcessNode_validateSource3() throws Exception {
        assertEquals(false, tcSourceWithHref.validateSource());
    }

    public void testProcessNode_validateExpected3() throws Exception {
        assertEquals(false, tcSourceWithHref.validateExpected());
    }

    public void testProcessNode_useSourceParser3() throws Exception {
        assertEquals(false, tcSourceWithHref.useSourceParser());
    }

    public void testProcessNode_transformSource3() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
            "    <content>" +
            "      <para>Using an external file in a TDF</para>" +
            "    </content>" +
            "  </file>" +
            "</utfx-wrapper>";
        String actualXml = sourceSerializer.serialize(tcSourceWithHref.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }

    public void testGetExpectedString3() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
            "    <content>" +
            "      <para>Using an external file in a TDF</para>" +
            "    </content>" +
            "  </file>" +
            "</utfx-wrapper>";
        String actualXml = tcSourceWithHref.getExpectedString();
        assertEquivXML(expectedXml, actualXml);
    }

    
    // using UTFX test case 4

    public void testProcessNode_getFailureMessage4() throws Exception {
        assertEquals("UTF-X test failed", tcExpectedWithHref.getFailureMessage());
    }

    public void testProcessNode_validateSource4() throws Exception {
        assertEquals(false, tcExpectedWithHref.validateSource());
    }

    public void testProcessNode_validateExpected4() throws Exception {
        assertEquals(false, tcExpectedWithHref.validateExpected());
    }

    public void testProcessNode_useSourceParser4() throws Exception {
        assertEquals(false, tcExpectedWithHref.useSourceParser());
    }

    public void testProcessNode_transformSource4() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
            "    <content>" +
            "      <para>Using an external file in a TDF</para>" +
            "    </content>" +
            "  </file>" +
            "</utfx-wrapper>";
        String actualXml = sourceSerializer.serialize(tcExpectedWithHref.getTransformSource()); 
        assertEquivXML(expectedXml, actualXml);
    }

    public void testGetExpectedString4() throws Exception {
        String expectedXml = 
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
            "<utfx-wrapper>" + 
            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
            "    <content>" +
            "      <para>Using an external file in a TDF</para>" +
            "    </content>" +
            "  </file>" +
            "</utfx-wrapper>";
        String actualXml = tcExpectedWithHref.getExpectedString();
        assertEquivXML(expectedXml, actualXml);
    }

   
    // Commented out because an test with an absolute external path can't be executed on another environment
    // using UTFX test case 5
    //
    //    public void testProcessNode_getFailureMessage5() throws Exception {
    //        assertEquals("UTF-X test failed", tcSourceWithHrefAbsolute.getFailureMessage());
    //    }
    //
    //    public void testProcessNode_validateSource5() throws Exception {
    //        assertEquals(false, tcSourceWithHrefAbsolute.validateSource());
    //    }
    //
    //    public void testProcessNode_validateExpected5() throws Exception {
    //        assertEquals(false, tcSourceWithHrefAbsolute.validateExpected());
    //    }
    //
    //    public void testProcessNode_useSourceParser5() throws Exception {
    //        assertEquals(false, tcSourceWithHrefAbsolute.useSourceParser());
    //    }
    //
    //    public void testProcessNode_transformSource5() throws Exception {
    //        String expectedXml = 
    //            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + 
    //            "<utfx-wrapper>" + 
    //            "  <file name=\"xslt_transform_test_case_test_1_input.xml\">" +
    //            "    <content>" +
    //            "      <para>Using an external file in a TDF</para>" +
    //            "    </content>" +
    //            "  </file>" +
    //            "</utfx-wrapper>";
    //        String actualXml = sourceSerializer.serialize(tcSourceWithHrefAbsolute.getTransformSource()); 
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
