package utfx.samples.test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.dom.DOMSource;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.w3c.dom.Document;
import org.w3c.dom.Node;

import utfx.framework.UTFXTestCase;
import utfx.samples.ContentFilterExample;
import utfx.util.DOMWriter;


/**
 * utfx.samples. test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/samples/test/ContentFilterExampleTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2005/03/09 03:53:21 $ $Name:  $
 */
public class ContentFilterExampleTest extends UTFXTestCase {

    private String testDir = "utfx/samples/test/";

    ContentFilterExample dsbe;


    /**
     * Constructs a test with a specified name.
     * 
     * @param name the test name
     */
    public ContentFilterExampleTest(String name) throws Exception {
        super(name);
    }

    /**
     * 
     * @throws Exception
     */
    public void testGetSource1() throws Exception {
        DOMSource domSource;
        DocumentBuilderFactory dbf;
        Document doc;
        Node node;
        ByteArrayOutputStream baos = new ByteArrayOutputStream(0xFF);
        DOMWriter domWriter;
        InputStream testInStream;
        InputStream expectedInStream;
        ByteArrayInputStream actualInStream;

        testInStream = ClassLoader.getSystemResourceAsStream(testDir
                + "dom_source_builder_example_test_1.xml");
        
        expectedInStream = ClassLoader.getSystemResourceAsStream(testDir
                + "dom_source_builder_example_expected_1.xml");        

        dbf = DocumentBuilderFactory.newInstance();

        dsbe = new ContentFilterExample("html");
        domSource = (DOMSource) dsbe.getSource(testInStream);
        node = domSource.getNode();
        doc = node.getOwnerDocument();
        
        domWriter = new DOMWriter(baos);
        domWriter.print(node);
        actualInStream = new ByteArrayInputStream(baos.toByteArray());
        
        //assertEquivXML("failed", expectedInStream, actualInStream);
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(ContentFilterExampleTest.class);
        return suite;
    }
}