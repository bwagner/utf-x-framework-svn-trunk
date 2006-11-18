package utfx.framework;

import junit.framework.ComparisonFailure;

/**
 * String comparison failure. This class extends the JUnit Comparisonailure so
 * that when UTF-X tests are executed directly within JUnit framework then test
 * failures can still be shown in a meaningful way.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/StringComparisonFailure.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class StringComparisonFailure extends ComparisonFailure {

    /**
     * Comment for <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = 3905799781904101429L;

    /** failure message */
    private String failureMessage;

    /**
     * the starting part of the XML content that is the same between expected
     * and actual
     */
    private String sameContent;

    private String diffExpected;

    private String diffActual;

    /**
     * Create a new StringComparisonFailure.
     * 
     * @param message
     * @param expected
     * @param actual
     */
    public StringComparisonFailure(String message, String expected,
            String actual) {
        super(message, expected, actual);
        this.failureMessage = message;
        byte[] expectedBytes = expected.getBytes();
        byte[] actualBytes = actual.getBytes();
        int index;

        // this loop will give us the index at which the two byte arrays begin
        // to differ
        for (index = 0; index < expectedBytes.length; index++) {
            try {
                if (expectedBytes[index] != actualBytes[index]) {
                    break;
                }
            } catch (IndexOutOfBoundsException e) {
                break;
            }
        }

        sameContent = new String(expectedBytes, 0, index);

        // check if we past the end of the array; if not then
        // print the remaining characters in a different colour
        if (index <= expectedBytes.length) {
            diffExpected = new String(expectedBytes, index,
                    expectedBytes.length - index);
        }

        // check if we past the end of the array; if not then
        // print the remaining characters in a different colour
        if (index <= actualBytes.length) {
            diffActual = new String(actualBytes, index, actualBytes.length
                    - index);
        }

    }

    /** @return feilureMessage */
    public String getMessage() {
        return failureMessage;
    }

    /**
     * @return Returns the diffActual.
     */
    public String getDiffActual() {
        return diffActual;
    }

    /**
     * @return Returns the diffExpected.
     */
    public String getDiffExpected() {
        return diffExpected;
    }

    /**
     * @return Returns the sameContent.
     */
    public String getSameContent() {
        return sameContent;
    }
}
