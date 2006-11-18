package utfx.testgen.test;

import java.io.FileInputStream;

import junit.framework.Test;
import junit.framework.TestSuite;
import utfx.framework.UTFXTestCase;
import utfx.samples.ContentFilterExample;
import utfx.testgen.TestGenerator;

/**
 * utfx.testgen.TestGenerator test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/testgen/test/TestGeneratorTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Alex Daniel
 * @version $Revision: 1.4.2.4 $ $Date: 2006/08/21 16:21:01 $ $Name:  $
 */
public class TestGeneratorTest extends UTFXTestCase {

    ContentFilterExample dsbe;

    /**
     * Constructs a test with a specified name.
     * 
     * @param name
     *            the test name
     */
    public TestGeneratorTest(String name) throws Exception {
        super(name);
    }

    public void testIsValidElementName() throws Exception {

        assertEquals("'element' is a valid name", true, TestGenerator
                .isValidElementName("element"));

        assertEquals("'text()' is NOT a valid element name", false,
                TestGenerator.isValidElementName("text()"));

        assertEquals("'/' is NOT a valid element name", false, TestGenerator
                .isValidElementName("/"));
        assertTrue(TestGenerator.isValidElementName("test-elemnt"));

    }

    public void testGetTestFilename() throws Exception {
        TestGenerator tg;
        if ("Linux".equals(System.getProperty("os.name"))) {
            tg = new TestGenerator("/file.xsl");
            assertEquals("/test/file_test.xml", tg.getTestFilename());

            tg = new TestGenerator("/some/long/path/some_stylesheet.xsl");
            assertEquals("/some/long/path/test/some_stylesheet_test.xml", tg
                    .getTestFilename());

            tg = new TestGenerator("/home/jacekrad/file.xsl");
            assertEquals("/home/jacekrad/test/file_test.xml", tg
                    .getTestFilename());
        }
    }
    
    public void testTemplatesWithMatch1() throws Exception {
        runMainTest("templates_with_match_1");
    }

    public void testTemplatesWithMatch2() throws Exception {
        runMainTest("templates_with_match_2");
    }

    public void testTemplatesWithName() throws Exception {
        runMainTest("templates_with_name");
    }
    
    public void testTemplatesMixed() throws Exception {
        runMainTest("templates_mixed");
    }
    
    public void testTemplatesWithParams() throws Exception {
        runMainTest("templates_with_params");
    }

    /**
     * Runs the TestGenerator with file testgen/${basename}.xsl
     * and compares the generated file with the file in testgen/expected
     * 
     * @param basename
     * @throws Exception
     */
    private void runMainTest(String basename) throws Exception {
        String basedir = "testgen/";
        
        String xslFilename = basename + ".xsl";
        String tdfFilename = basename + "_test.xml";
        
        String inputPath = basedir + xslFilename;
        String outputPath = basedir + "test/" + tdfFilename;
        String expectedPath = basedir + "expected/" + tdfFilename;
        
        String[] args = new String[] { "-xslt", inputPath, "-f" };
        TestGenerator.main(args);
        FileInputStream expected = new FileInputStream(expectedPath);
        FileInputStream actual = new FileInputStream(outputPath);
        assertEquivXML(expected, actual);        
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(TestGeneratorTest.class);
        return suite;
    }
}