package utfx.framework;

import junit.framework.AssertionFailedError;

/**
 * TODO class description.
 * 
 * <p>
 * Copyright &copy; 2005 USQ and others.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/XMLValidationError.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class XMLValidationError extends AssertionFailedError {

    /**
     * 
     */
    public XMLValidationError() {
        super();
    }

    /**
     * @param message
     */
    public XMLValidationError(String message) {
        super(message);
    }

}
