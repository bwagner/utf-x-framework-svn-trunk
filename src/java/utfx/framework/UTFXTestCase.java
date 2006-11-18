package utfx.framework;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import junit.framework.TestCase;
import utfx.util.CanonicalForm;

/**
 * UTF-X test case extends junit test case and adds functionality required for
 * testing XSLT stylesheets and the UTF-X framework itself.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/UTFXTestCase.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver (Lulu) Lucido
 * @version $Revision: 1.3.2.3 $ $Date: 2006/09/07 06:29:53 $ $Name:  $
 */
public class UTFXTestCase extends TestCase {

    protected boolean normaliseInternalWhitespace;

    /**
     * @param name
     */
    public UTFXTestCase(String name) {
        super(name);
    }

    /**
     * Asserts that the two specified byte arrays are equal.
     * 
     * @param message
     *            failed message
     * @param b1
     *            expected bytes
     * @param b2
     *            actual bytes
     */
    public void assertEquals(String message, byte[] b1, byte[] b2)
            throws Exception {
        String localMessage = ""; // append this to message
        int index;
        boolean passed = true;
        String expected, actual;

        for (index = 0; index < b1.length; index++) {
            try {
                if (b1[index] != b2[index]) {
                    localMessage = "byte arrays differ at offset " + index;
                    passed = false;
                    break;
                }
            } catch (IndexOutOfBoundsException e) {
                localMessage = "expected byte array (" + b1.length
                        + " bytes) is longer than actual (" + b1.length
                        + " bytes).";
                passed = false;
                break;
            }
        }

        // but if b2 is bigger than b1 then they aren't equal
        if (passed && b2.length > b1.length) {
            localMessage = "actual byte array (" + b2.length
                    + " bytes) is longer than expected (" + b1.length
                    + " bytes).";
            passed = false;
        }

        if (passed) {
            return;
        }

        expected = new String(b1, 0, index);

        // check if we past the end of the array; if not then
        // print the remaining characters in a different colour
        if (index <= b1.length) {
            expected += new String(b1, index, b1.length - index);
        }

        actual = new String(b2, 0, index);

        // check if we past the end of the array; if not then
        // print the remaining characters in a different colour
        if (index <= b2.length) {
            actual += new String(b2, index, b2.length - index);
        }
        throw new StringComparisonFailure(message + ": " + localMessage,
                expected, actual);
    }

    /**
     * Asserts that the two specified byte arrays are equal.
     * 
     * @param b1
     *            expected bytes
     * @param b2
     *            actual bytes
     */
    public void assertEquals(byte[] b1, byte[] b2) throws Exception {
        assertEquals("byte arrays are not equal", b1, b2);
    }

    /**
     * Asserts that two input streams are byte equivalent.
     * 
     * @param failed
     *            message
     * @param expected
     *            the expected XML input stream
     * @param actual
     *            the actual XML input stream
     */
    public void assertEquals(String message, InputStream expected,
            InputStream actual) throws Exception {

        byte[] expectedBytes = new byte[4096];
        byte[] actualBytes = new byte[4096];

        int bytesRead1 = 0;
        int bytesRead2 = 0;
        String expectedContent = "";
        String actualContent = "";

        // first input stream
        while ((bytesRead1 = expected.read(expectedBytes)) > -1) {
            expectedContent += new String(expectedBytes, 0, bytesRead1);
            expectedBytes = new byte[4096];
        }

        // second input stream
        while ((bytesRead2 = actual.read(actualBytes)) > -1) {
            actualContent += new String(actualBytes, 0, bytesRead2);
            actualBytes = new byte[4096];
        }

        // compare the byte arrays
        assertEquals(message, expectedContent.getBytes(), actualContent
                .getBytes());
    }

    /**
     * Asserts that two input streams are byte equivalent.
     * 
     * @param expected
     *            the expected XML input stream
     * @param actual
     *            the actual XML input stream
     */
    public void assertEquals(InputStream expected, InputStream actual)
            throws Exception {
        assertEquals("input streams differ", expected, actual);
    }

    /**
     * Asserts that two XML input streams are equivalent, which means their
     * canonical forms are equal, when transformed using
     * <code>utfx.util.CanonicalForm</code>. If they are not an
     * StringComparisonFailure is thrown with the given message.
     * 
     * @param message
     *            the message thrown with the AssertionFailedError
     * @param expected
     *            the expected XML input stream
     * @param actual
     *            the actual XML input stream
     * @throws StringComparisonFailure
     */
    public void assertEquivXML(String message, InputStream expected,
            InputStream actual) throws Exception {
        CanonicalForm cf;
        ByteArrayOutputStream expectedBaos, actualBaos;
        ByteArrayInputStream expectedBais, actualBais;
        byte[] expectedBytes = new byte[1];
        byte[] actualBytes = new byte[1];
        int bytesRead;
        byte[] buffer = new byte[1024];
        StringBuffer expectedContent = new StringBuffer();
        StringBuffer actualContent = new StringBuffer();

        actualBaos = new ByteArrayOutputStream();
        expectedBaos = new ByteArrayOutputStream();

        // read the expected and actual InputStreams into
        // StringBuffers
        while ((bytesRead = expected.read(buffer)) != -1) {
            expectedContent.append(new String(buffer, 0, bytesRead, "UTF8"));
        }

        while ((bytesRead = actual.read(buffer)) != -1) {
            actualContent.append(new String(buffer, 0, bytesRead, "UTF8"));
        }

        // if both are empty or only whitespace then the test passes
        if (expectedContent.toString().trim().equals("")
                && actualContent.toString().trim().equals("")) {
            return;
        }

        // create ByteArrayInputStreams from the StringBuffers
        actualBais = new ByteArrayInputStream(actualContent.toString()
                .getBytes("UTF8"));
        expectedBais = new ByteArrayInputStream(expectedContent.toString()
                .getBytes("UTF8"));

        // transform the inputs to their canonical form, if they
        // are not empty
        cf = new CanonicalForm();
        cf.setNormaliseWhitespace(normaliseInternalWhitespace);

        if (!(expectedContent.toString().trim().equals(""))) {
            cf.transform(expectedBais, expectedBaos);
        }
        if (!(actualContent.toString().trim().equals(""))) {
            cf.transform(actualBais, actualBaos);
        }

        // test if the two XML byte arrays are equal
        expectedBytes = expectedBaos.toByteArray();
        actualBytes = actualBaos.toByteArray();
        assertEquals(message, expectedBytes, actualBytes);

    }

    /**
     * Asserts that two XML input streams are equivalent, which means their
     * canonical forms are equal, when transformed using
     * <code>utfx.util.CanonicalForm</code>. If they are not an
     * StringComparisonFailure is thrown with the given message.
     * 
     * @param expected
     *            the expected XML input stream
     * @param actual
     *            the actual XML input stream
     * @throws StringComparisonFailure
     */
    public void assertEquivXML(InputStream expected, InputStream actual)
            throws Exception {
        assertEquivXML("XML streams differ", expected, actual);
    }

    /**
     * Convenience method for comparing two XML strings. Basically a wrapper for
     * <code>assertEquivXML<String, InputStream, InputStream)</code> with the
     * default message &quot;The XML specified are not equivalent&quot;
     * 
     * @param message
     *            failed message
     * @param expected
     * @param actual
     * @see junit.framework.Assert
     */
    public void assertEquivXML(String message, String expected, String actual)
            throws Exception {
        try {
            assertEquivXML(message, new ByteArrayInputStream(expected
                    .getBytes("UTF8")), new ByteArrayInputStream(actual
                    .getBytes("UTF8")));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    /**
     * Convenience method for comparing two XML strings. Basically a wrapper for
     * <code>assertEquivXML<String, InputStream, InputStream)</code> with the
     * default message &quot;The XML specified are not equivalent&quot;
     * 
     * @param expected
     * @param actual
     * @see junit.framework.Assert
     */
    public void assertEquivXML(String expected, String actual) throws Exception {
        assertEquivXML("XML strings are not equivalent", expected, actual);
    }
}
