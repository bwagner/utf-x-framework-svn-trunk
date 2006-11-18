package utfx.framework.test;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.apache.xml.resolver.tools.CatalogResolver;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import utfx.framework.UTFXNamespaceContext;
import utfx.framework.UTFXTestCase;
import utfx.framework.WrapperStylesheetGenerator;
import utfx.util.DOMWriter;

/**
 * Junit Tests for WrapperStylesheetGenerator
 * 
 * <p>
 * Copyright &copy; 2006 UTF-X Development Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/Attic/WrapperStylesheetGeneratorTest.java,v $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: 1.1.2.3 $ $Date: 2006/08/22 14:57:08 $ $Name:  $
 */

public class WrapperStylesheetGeneratorTest extends TestCase {

    /**
     * Constructs a test with a specified name.
     * 
     * @param name
     *            the test name
     */
    public WrapperStylesheetGeneratorTest(String name) throws Exception {
        super(name);
    }

    /**
     * Serialize the given node to a String.
     * 
     * @param node
     * @return serialized string
     * @throws Exception
     */
    private String serializeNode(Node node) throws Exception {
        String result;

        ByteArrayOutputStream baos;
        DOMWriter domWriter;
        baos = new ByteArrayOutputStream();
        domWriter = new DOMWriter(baos);
        domWriter.print(node);
        result = new String(baos.toString());

        return result;
    }

    /** XPath factory */
    private XPathFactory xpf;

    /** XPath */
    private XPath xpath;

    /** DOM Document builder factory */
    private DocumentBuilderFactory dbf;

    /** DOM Document builder */
    private DocumentBuilder db;

    /** Object under test */
    private WrapperStylesheetGenerator gen;

    /** TDF serving as input data for tests */
    private Document testDoc;

    /**
     * Create objects needed for test cases
     * 
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());

        dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        dbf.setExpandEntityReferences(false);
        dbf.setValidating(false);
        db = dbf.newDocumentBuilder();
        db.setEntityResolver(new CatalogResolver());

        gen = new WrapperStylesheetGenerator(
                "file:/tests/stylesheetUnderTest.xsl");
        testDoc = db
                .parse(new FileInputStream(
                        "src/java/utfx/framework/test/WrapperStylesheetGeneratorTestTDF.xml"));
    }

    /**
     * Test case for getStylesheetUnderTestURI() method
     */
    public void testGetStylesheetUnderTestURI() {
        assertEquals("file:/tests/stylesheetUnderTest.xsl", gen
                .getStylesheetUnderTestURI());
    }

    public void testGetWrapper0() throws Exception {
        runGetWrapperTest(testDoc, 0);
    }

    public void testGetWrapper1() throws Exception {
        runGetWrapperTest(testDoc, 1);
    }

    public void testGetWrapper2() throws Exception {
        runGetWrapperTest(testDoc, 2);
    }

    public void testGetWrapper3() throws Exception {
        runGetWrapperTest(testDoc, 3);
    }

    public void testGetWrapper4() throws Exception {
        runGetWrapperTest(testDoc, 4);
    }

    public void testGetWrapper5() throws Exception {
        runGetWrapperTest(testDoc, 5);
    }

    public void testGetWrapper6() throws Exception {
        runGetWrapperTest(testDoc, 6);
    }

    public void testGetWrapper7() throws Exception {
        runGetWrapperTest(testDoc, 7);
    }

    public void testGetWrapper8() throws Exception {
        runGetWrapperTest(testDoc, 8);
    }

    public void testGetWrapper9() throws Exception {
        runGetWrapperTest(testDoc, 9);
    }

    public void testGetWrapper10() throws Exception {
        runGetWrapperTest(testDoc, 10);
    }

    public void testGetWrapper11() throws Exception {
        runGetWrapperTest(testDoc, 11);
    }

    public void testGetWrapper12() throws Exception {
        runGetWrapperTest(testDoc, 12);
    }

    public void testGetWrapper13() throws Exception {
        runGetWrapperTest(testDoc, 13);
    }

    public void testGetWrapper14() throws Exception {
        runGetWrapperTest(testDoc, 14);
    }

    public void testGetWrapper15() throws Exception {
        runGetWrapperTest(testDoc, 15);
    }

    public void testGetWrapper16() throws Exception {
        runGetWrapperTest(testDoc, 16);
    }

    public void testGetWrapper17() throws Exception {
        runGetWrapperTest(testDoc, 17);
    }

    /**
     * Reads test case from TDF and expected result from filesystem and compares
     * the results with the help of UTFXTestCase
     * 
     * @param testDoc -
     *            TDF
     * @param i -
     *            test from testDoc starting from 0
     * @throws Exception
     */
    private void runGetWrapperTest(Document testDoc, int i) throws Exception {
        Element testElement = (Element) xpath.evaluate("//utfx:test[" + (i + 1)
                + "]", testDoc.getDocumentElement(), XPathConstants.NODE);

        // create expected document
        String filenameExpectedWrapperDoc = "src/java/utfx/framework/test/WrapperStylesheetGeneratorTestExpected"
                + i + ".xsl";
        Document expectedDoc = db.parse(new FileInputStream(
                filenameExpectedWrapperDoc));
        String expected = serializeNode(expectedDoc.getDocumentElement());

        // actual result
        Document wrapperDoc = gen.getWrapper(testElement);
        String actual = serializeNode(wrapperDoc.getDocumentElement());

        // compare expected and actual with UTFXTestCase
        String name = "WrapperStylesheetGeneratorTest" + i;
        String failureMsg = name + " failed";
        UTFXTestCase testCase = new UTFXTestCase(name);
        testCase.assertEquivXML(failureMsg, expected, actual);
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(WrapperStylesheetGeneratorTest.class);
        return suite;
    }
}