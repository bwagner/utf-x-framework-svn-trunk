package utfx.util.test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import junit.framework.AssertionFailedError;
import junit.framework.Test;
import junit.framework.TestSuite;
import utfx.framework.UTFXTestCase;
import utfx.util.CanonicalForm;

/**
 * utfx.util.CanonicalForm test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/util/test/CanonicalFormTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido (Lulu)
 * @author Stephano AhFock (Bob)
 * @version $Revision: 1.2.2.1 $ $Name:  $
 */
public class CanonicalFormTest extends UTFXTestCase {

    private String testDir = "utfx/util/test/";

    /**
     * Constructs a test with a specified name.
     * 
     * @param name
     *            the test name
     */
    public CanonicalFormTest(String name) throws Exception {
        super(name);
    }

    /**
     * This method contains the plumbing for using the CanonicalFrom.transform()
     * method.
     * 
     * @param useW3CSpec
     *            see CanonicalForm for details
     * @param source
     *            InputStream of the test source (most likely a file)
     * @param expected
     *            InputStream of the expected (most likely a file)
     * @param actual
     *            OutputStream to which the the result of transforming the
     *            source will be written to.
     * 
     * @throws Exception
     *             upon an error.
     */
    private void compareXML(boolean useW3CSpec, InputStream source,
            InputStream expected, OutputStream actual) throws Exception {
        CanonicalForm cf;
        byte[] buffer;
        int bytesRead;
        ByteArrayOutputStream expectedBaos, actualBaos;

        expectedBaos = new ByteArrayOutputStream();
        actualBaos = new ByteArrayOutputStream();

        // transform the source to its canonical form
        cf = new CanonicalForm(useW3CSpec);
        cf.transform(source, actualBaos);

        // output the transformed XML
        if (actual != null) {
            actual.write(actualBaos.toByteArray());
        }

        // create a byte array from the expected input stream
        buffer = new byte[4096];
        while ((bytesRead = expected.read(buffer)) > -1) {
            expectedBaos.write(buffer, 0, bytesRead);
            buffer = new byte[4096];
        }

        // test if the two XML byte arrays are equal
        assertEquals(expectedBaos.toByteArray(), actualBaos.toByteArray());
    }

    /**
     * This method contains the plumbing for using the CanonicalFrom.transform()
     * method.
     * 
     * @param source
     *            InputStream of the test source (most likely a file)
     * @param expected
     *            InputStream of the expected (most likely a file)
     * @param actual
     *            OutputStream to which the the result of transforming the
     *            source will be written to.
     * 
     * @throws Exception
     *             upon an error.
     */
    private void compareWhitespaceNormalisedXML(InputStream source,
            InputStream expected, OutputStream actual) throws Exception {
        CanonicalForm cf;
        byte[] buffer;
        int bytesRead;
        ByteArrayOutputStream expectedBaos, actualBaos;

        expectedBaos = new ByteArrayOutputStream();
        actualBaos = new ByteArrayOutputStream();

        // transform the source to its canonical form
        cf = new CanonicalForm(true);
        cf.setNormaliseWhitespace(true);
        cf.transform(source, actualBaos);

        // output the transformed XML
        if (actual != null) {
            actual.write(actualBaos.toByteArray());
        }

        // create a byte array from the expected input stream
        buffer = new byte[4096];
        while ((bytesRead = expected.read(buffer)) > -1) {
            expectedBaos.write(buffer, 0, bytesRead);
            buffer = new byte[4096];
        }

        // test if the two XML byte arrays are equal
        assertEquals(expectedBaos.toByteArray(), actualBaos.toByteArray());
    }

    /**
     * Transforms a source XML document and compares the output to the expected
     * XML file.
     */
    public void testTransform1() throws Exception {
        InputStream test;
        InputStream expected;

        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_1.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_1.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream());
    }

    public void testTransform2() throws Exception {
        InputStream test;
        InputStream expected;

        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_2.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_2.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream(0x100));
    }

    // the two tests below don't work yet as CanonicalForm is not
    // completely compliant with the W3C Canonical XML specification

    // public void testTransform3() throws Exception {
    // compareXML
    // (true,
    // new FileInputStream(testDir + "canonical_form_test_3.xml"),
    // new FileInputStream(testDir + "canonical_form_expected_3.xml"),
    // new FileOutputStream(testDir + "canonical_form_output_3.xml"));
    // }

    // public void testTransform4() throws Exception {
    // compareXML
    // (true,
    // new FileInputStream(testDir + "canonical_form_test_4.xml"),
    // new FileInputStream(testDir + "canonical_form_expected_4.xml"),
    // new FileOutputStream(testDir + "canonical_form_output_4.xml"));
    // }

    public void testTransform5() throws Exception {
        InputStream test;
        InputStream expected;
        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_5.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_5.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream());
    }

    public void testTransform6() throws Exception {
        InputStream test;
        InputStream expected;
        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_6.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_6.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream());
    }

    public void testTransform7() throws Exception {
        InputStream test;
        InputStream expected;
        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_7.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_7.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream());
    }

    public void testTransform8() throws Exception {
        InputStream test;
        InputStream expected;
        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_8.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_8.xml");
        compareXML(true, test, expected, new ByteArrayOutputStream());
    }

    /**
     * Tests that CanonicalForm is idempotent.
     */
    public void testIdempotency() throws Exception {
        InputStream test;
        InputStream expected;
        ByteArrayOutputStream outputBytes1, outputBytes2;

        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_6.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_6.xml");
        outputBytes1 = new ByteArrayOutputStream();
        outputBytes2 = new ByteArrayOutputStream();

        // first canonicalization
        compareXML(true, test, expected, outputBytes1);

        // second canonicalization
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_6.xml");
        compareXML(true, new ByteArrayInputStream(outputBytes1.toByteArray()),
                expected, outputBytes2);

        // third canonicalization
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_6.xml");
        compareXML(true, new ByteArrayInputStream(outputBytes2.toByteArray()),
                expected, new ByteArrayOutputStream());
    }

    /**
     * This method tests whitespace normalisation. Plese see <a
     * href="https://utf-x.dev.java.net/issues/show_bug.cgi?id=62">issue 62</a>
     * for more details.
     * 
     * @throws Exception
     *             upon error.
     */
    public void testWhitespaceNormalisation1() throws Exception {
        InputStream test;
        InputStream expected;
        ByteArrayOutputStream actual;

        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_normalise_whitespace_1.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_normalise_whitespace_1.xml");
        actual = new ByteArrayOutputStream(0x100);

        compareWhitespaceNormalisedXML(test, expected, actual);
    }

    /**
     * This method tests whitespace normalisation. Plese see <a
     * href="https://utf-x.dev.java.net/issues/show_bug.cgi?id=62">issue 62</a>
     * for more details. This method uses the same XML test file as
     * testWhitespaceNormalisation1(), except in this case we test for
     * normaliseWhitespace = false.
     * 
     * @throws Exception
     *             upon error.
     */
    public void testWhitespaceNormalisation2() throws Exception {
        InputStream test;
        InputStream expected;
        ByteArrayOutputStream actual;

        test = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_test_normalise_whitespace_1.xml");
        expected = ClassLoader.getSystemResourceAsStream(testDir
                + "canonical_form_expected_normalise_whitespace_1.xml");
        actual = new ByteArrayOutputStream(0x100);

        try {
            compareXML(true, test, expected, actual);
            fail("White space has been normalised even thought it should have been");            
        } catch (AssertionFailedError afe) {
            // expecting AssertionFailedError
        }
    }

    /**
     * Gets a reference to this test suite.
     * 
     * @return this test suite.
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(CanonicalFormTest.class);
        return suite;
    }
}