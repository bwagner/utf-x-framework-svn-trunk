package utfx.framework.test;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import junit.framework.Test;
import junit.framework.TestSuite;

import org.w3c.dom.Document;

import utfx.framework.DefaultSourceParser;
import utfx.framework.SourceParser;
import utfx.framework.SourceParserFactory;
import utfx.framework.SourceParserWrapper;
import utfx.framework.UTFXTestCase;

/**
 * test for class SourceParserFactory.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/SourceParserFactoryTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class SourceParserFactoryTest extends UTFXTestCase {

    DocumentBuilderFactory dbf;

    DocumentBuilder db;

    String testDir = "utfx/framework/test/";

    public SourceParserFactoryTest(String name) {
        super(name);
    }

    public void setUp() throws Exception {
        dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        db = dbf.newDocumentBuilder();
    }

    public void testLoad1() throws Exception {

        Document doc;
        SourceParserFactory sbl = new SourceParserFactory();
        SourceParser sourceBuilder;

        doc = db.parse(ClassLoader.getSystemResourceAsStream(testDir
                + "source_builder_loader_test_1.xml"));

        sourceBuilder = sbl.getSourceParser(doc.getDocumentElement());

        assertTrue("expected DefaultSourceParser got "
                + sourceBuilder.getClass(),
                sourceBuilder instanceof DefaultSourceParser);
    }

    public void testLoad2() throws Exception {

        Document doc;
        SourceParserFactory sbl = new SourceParserFactory();
        SourceParser sourceBuilder;
        SourceParserWrapper wrapper;
        TestSourceParser1 testSourceBuilder;

        doc = db.parse(ClassLoader.getSystemResourceAsStream(testDir
                + "source_builder_loader_test_2.xml"));

        sourceBuilder = sbl.getSourceParser(doc.getDocumentElement());

        assertTrue("expected SourceParserWrapper got "
                + sourceBuilder.getClass(),
                sourceBuilder instanceof SourceParserWrapper);
        wrapper = (SourceParserWrapper) sourceBuilder;
        testSourceBuilder = (TestSourceParser1) wrapper.getSourceBuilder();
        assertEquals("parameter 1", testSourceBuilder.getP1());
        assertEquals("parameter 2", testSourceBuilder.getP2());
    }

    public void testLoad3() throws Exception {

        Document doc;
        SourceParserFactory sbl = new SourceParserFactory();
        SourceParser sourceBuilder;
        TestSourceParser2 testSourceBuilder;

        doc = db.parse(ClassLoader.getSystemResourceAsStream(testDir
                + "source_builder_loader_test_3.xml"));

        sourceBuilder = sbl.getSourceParser(doc.getDocumentElement());

        assertTrue("expected ", sourceBuilder instanceof TestSourceParser2);

        testSourceBuilder = (TestSourceParser2) sourceBuilder;
        assertEquals("parameter 1", testSourceBuilder.getP1());
        assertEquals(new Integer(42), testSourceBuilder.getP2());
        assertEquals("parameter 3", testSourceBuilder.getP3());
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(SourceParserFactoryTest.class);
        return suite;
    }

}
