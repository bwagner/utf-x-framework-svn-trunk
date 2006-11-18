package utfx.framework;

/**
 * Represents broken UTF-X test.
 * 
 * <p>
 * Copyright &copy; 2004 - 2005 USQ and others</a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/MalformedTestException.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class MalformedTestException extends RuntimeException {

    /**
     * Comment for <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = 1L;

    /**
     * 
     */
    public MalformedTestException() {
        super();
    }

    /**
     * @param message
     */
    public MalformedTestException(String message) {
        super(message);
    }

    /**
     * @param message
     * @param cause
     */
    public MalformedTestException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * @param cause
     */
    public MalformedTestException(Throwable cause) {
        super(cause);
    }

}
