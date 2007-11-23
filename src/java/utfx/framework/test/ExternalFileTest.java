package utfx.framework.test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import utfx.framework.ExternalFile;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * JUnit test for ExternalFile.
 * @see utfx.framework.ExternalFile
 * 
 * <p>
 * Copyright &copy; 2007 UTF-X Development Team.
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
 * $Source: $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: $ $Date: $ $Name: $
 */
public class ExternalFileTest extends TestCase {

    /**
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        super.setUp();
    }

    /**
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void testIsAvailableFalse() {
        ExternalFile externalFile = new ExternalFile(null, null);
        assertFalse(externalFile.isAvailable());
    }

    public void testIsAvailableTrue() {
        ExternalFile externalFile = new ExternalFile("filename", null);
        assertTrue(externalFile.isAvailable());
    }

    public void testGetNameAssertion() {
        ExternalFile externalFile = new ExternalFile(null, null);
        try {
            externalFile.getName();
            fail("Expected AssertionError");
        } catch (AssertionError e) {
            // nothing to be done. That's what we expected
        }
    }
    
    public void testGetName() {
        ExternalFile externalFile = new ExternalFile("filename", null);
        assertEquals("filename", externalFile.getName());
    }

    public void testGetNodes() throws ParserConfigurationException, FileNotFoundException, SAXException, IOException {
        ExternalFile externalFile = new ExternalFile("ExternalFileTest1.xml", new File("src/java/utfx/framework/test/ExternalFileTest.java"));
        Document dstDocument = createDocument();
        
        NodeList nodeList = externalFile.getNodes(dstDocument);
        assertEquals(1, nodeList.getLength());
        
        Node node = nodeList.item(0);
        assertEquals(Node.ELEMENT_NODE, node.getNodeType());
        assertEquals("classUnderTest", node.getNodeName());
        assertEquals(1, node.getAttributes().getLength());
        assertEquals(Node.ATTRIBUTE_NODE, node.getAttributes().item(0).getNodeType());
        assertEquals("name", node.getAttributes().item(0).getNodeName());
        assertEquals(0, node.getChildNodes().getLength());
    }

    protected Document createDocument() throws ParserConfigurationException {
        DocumentBuilderFactory fact = DocumentBuilderFactory.newInstance();
        DocumentBuilder parser = fact.newDocumentBuilder();
        return parser.newDocument();
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(ExternalFileTest.class);
        return suite;
    }
    
}
