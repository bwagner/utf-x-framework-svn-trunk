package utfx.framework.test;

/**
 * Helper class for JUnit testing
 * 
 * <p>
 * Copyright &copy; 2008 UTF-X Development Team.
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
 * $Source: $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: $ $Date: $ $Name: $
 */
public class SystemPropertyRestorer {
	
	private final String key;
	private final String prevValue;
	
	public SystemPropertyRestorer(String key, String value) {
		this.key = key;
    	prevValue = System.setProperty(key, value);
		
	}
	
	public void restore() {
    	if (prevValue == null) {
    		System.clearProperty(key);
    	} else {
    		System.setProperty(key, prevValue);
    	}
	}

}
