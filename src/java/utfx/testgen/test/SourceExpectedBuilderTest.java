package utfx.testgen.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.w3c.dom.Document;

import utfx.framework.UTFXTestCase;
import utfx.testgen.SourceExpectedBuilder;

/**
 * utfx.testgen.SourceExpectedBuillder test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/testgen/test/SourceExpectedBuilderTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class SourceExpectedBuilderTest extends UTFXTestCase {

    private TransformerFactory tf;

    private Transformer t;

    private DocumentBuilderFactory dbf;

    private DocumentBuilder db;

    private String stylesheetName = "utfx/testgen/test/source_expected_builder_test.xsl";

    private String xmlDocName = "utfx/testgen/test/source_expected_builder_test.xml";

    /**
     * Constructs a test with a specified name.
     * 
     * @param name
     *            the test name
     */
    public SourceExpectedBuilderTest(String name) throws Exception {
        super(name);
        tf = TransformerFactory.newInstance();
        dbf = DocumentBuilderFactory.newInstance();
        db = dbf.newDocumentBuilder();

    }

    public void testGetSource() throws Exception {
        StreamSource ss;
        SourceExpectedBuilder seb;
        Document xmlDoc;
        ss = new StreamSource(ClassLoader
                .getSystemResourceAsStream(stylesheetName));
        xmlDoc = db.parse(ClassLoader.getSystemResourceAsStream(xmlDocName));
        t = tf.newTransformer(ss);
        seb = new SourceExpectedBuilder(t);
        seb.setXmlDoc(xmlDoc);
        assertEquivXML("<another-element><text>" + "some text in here"
                + "</text></another-element>", seb.getSource("another-element"));

    }

    public void testGetExpected() throws Exception {
        StreamSource ss;
        SourceExpectedBuilder seb;
        Document xmlDoc;
        ss = new StreamSource(ClassLoader
                .getSystemResourceAsStream(stylesheetName));
        xmlDoc = db.parse(ClassLoader.getSystemResourceAsStream(xmlDocName));
        t = tf.newTransformer(ss);
        seb = new SourceExpectedBuilder(t);
        seb.setXmlDoc(xmlDoc);
        assertEquivXML("<result-element><result-text>" + "some text in here"
                + "</result-text></result-element>", seb
                .getExpected("another-element"));

    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(SourceExpectedBuilderTest.class);
        return suite;
    }
}