package utfx.framework;

/**
 * This exception is thrown when a XSLT stylesheet that is being tested is invalid.
 * 
 * <p>
 * Copyright &copy; 2006 Jacek Radajewski</a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/MalformedStylesheetException.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2006/03/10 09:07:03 $ $Name:  $
 */
public class MalformedStylesheetException extends RuntimeException {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    public MalformedStylesheetException() {
        super();
    }

    /**
     * @param message
     */
    public MalformedStylesheetException(String message) {
        super(message);
    }

    /**
     * @param message
     * @param cause
     */
    public MalformedStylesheetException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * @param cause
     */
    public MalformedStylesheetException(Throwable cause) {
        super(cause);
    }

}
