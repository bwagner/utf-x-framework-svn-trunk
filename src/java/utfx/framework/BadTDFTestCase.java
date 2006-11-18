package utfx.framework;

/**
 * This test case represents a bad Test Definition File (TDF).
 * <p>
 * Copyright &copy; 2006 Jacek Radajewski
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/BadTDFTestCase.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1.2.1 $Date: 2006/08/21 03:09:01 $ $ $Name:  $
 */
public class BadTDFTestCase extends UTFXTestCase {

    private String message;

    /**
     * Creates a new BadTDFTestCase.
     * 
     * @param message
     *            message explaining the BADness.
     */
    public BadTDFTestCase(String message) {
        super("error");
        this.message = message;
    }

    public void error() throws Exception {
        throw new MalformedTestException(message);
    }
}
