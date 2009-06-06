package utfx.templateEngine;

import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.util.Map;

/**
 * Template engine interface for templates within TDF
 * <p>
 * Copyright &copy; 2009 UTF-X Development Team.
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
public interface TemplateEngine {
	/**
	 * Evaluate the template with context and write to output
	 * 
	 * @param template
	 * @param output
	 * @param context
	 *            it's type is Map<? extends Object, ? extends Object> according
	 *            to Joshua Bloch's PECS rule of Effective Java 2nd edition.
	 *            Parleys hosts a free talk of Joshua Bloch including PECS:
	 *            http://www.parleys.com/display/PARLEYS/Home#slide=5;title=
	 *            Effective%20Java%20Reloaded;talk=18317360
	 * @throws IOException
	 *             Using checked exception here since the checked IOException is part of
	 *             Writer interface
	 */
	public void evaluate(Reader template, Writer output, Map<? extends Object, ? extends Object> context) throws IOException;																																// http://www.parleys.com/display/PARLEYS/Home#title=Effective%20Java%20Reloaded;talk=18317360;slide=1
}
