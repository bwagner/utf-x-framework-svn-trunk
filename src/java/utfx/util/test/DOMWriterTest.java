package utfx.util.test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.w3c.dom.Document;

import utfx.framework.UTFXTestCase;
import utfx.util.DOMWriter;

/**
 * Simple validating parser wrapper. This XML validation utility uses a DOM
 * validating parser to parse the document and reports any warnings, errors and
 * fatal error using the weblogic logging facility. Please see the <a
 * href="http://www.w3.org/TR/REC-xml#sec-terminology">Extensible Markup
 * Language (XML) 1.0 (Second Edition) </a> W3C recommendation for a full
 * definition of <code>error</code> and <code>fatal
 * error</code>.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/util/test/DOMWriterTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido (Lulu)
 * @version $Revidion:$ $Date$ $Name:  $
 */
public class DOMWriterTest extends UTFXTestCase {

    private String testDir = "utfx/util/test/";

    /** A DOM document encoded in UTF8 */
    private Document utf8doc;

    /** A DOM document encoded in UTF16 */
    private Document utf16doc;

    /** The directory where all the test documents are stored. */
    /** Local class name (not FQN) */
    protected String className;

    /** Document builder factory. */
    protected DocumentBuilderFactory dbf = null;

    /** Document builder. */
    protected DocumentBuilder db = null;

    /**
     * Constructs a test with a specified name.
     */
    public DOMWriterTest(String name) {
        super(name);
    }

    /**
     * Create the document builder.
     */
    protected void setUp() throws Exception {

        dbf = DocumentBuilderFactory.newInstance();
        db = dbf.newDocumentBuilder();
    }

    /**
     * Tests a UTF8 encoded xml file and runs it through the DOMWriter. Fails if
     * the DOMWriter output doesn't match the expected.
     */
    public void testUTF8() throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        DOMWriter writer = new DOMWriter(baos);
        InputStream expected = ClassLoader.getSystemResourceAsStream(testDir
                + "dom_writer_expected_1_utf8.xml");

        utf8doc = db.parse(ClassLoader.getSystemResourceAsStream(testDir
                + "dom_writer_test_1_utf8.xml"));
        writer.print(utf8doc);

        assertEquivXML("DOMWriter failed to write UTF-8 file correctly",
                expected, new ByteArrayInputStream(baos.toByteArray()));
    }

    /**
     * Tests a UTF16 encoded xml file and runs it through the DOMWriter. Fails
     * if the DOMWriter output doesn't match the expected.
     */
    public void testUTF16() throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        DOMWriter writer = new DOMWriter(baos);
        InputStream expected = ClassLoader.getSystemResourceAsStream(testDir
                + "dom_writer_expected_2_utf16.xml");

        utf16doc = db.parse(ClassLoader.getSystemResourceAsStream(testDir
                + "dom_writer_test_2_utf16.xml"));
        writer.print(utf16doc);

        assertEquivXML("DOMWriter failed to write UTF-16 file correctly",
                expected, new ByteArrayInputStream(baos.toByteArray()));
    }

    /**
     * Creates a test suite for this class.
     * 
     * @return this test suite
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(DOMWriterTest.class);
        return suite;
    }

}
