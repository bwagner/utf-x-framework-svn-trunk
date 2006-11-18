package utfx.framework;

/**
 * This test case represents a bad XSLT stylesheet that is being tested.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/BadXSLTTestCase.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1.2.1 $Date: 2006/08/21 03:10:57 $ $ $Name:  $
 */
public class BadXSLTTestCase extends UTFXTestCase {

    private String message;

    /**
     * Creates a new BadXSLTTestCase.
     * 
     * @param message
     *            message explaining the BADness.
     */
    public BadXSLTTestCase(String message) {
        super("error");
        this.message = message;
    }

    public void error() throws Exception {
        throw new MalformedStylesheetException(message);
    }

}
