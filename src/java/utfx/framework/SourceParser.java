package utfx.framework;

import java.io.InputStream;

import javax.xml.transform.Source;

/**
 * SourceParser interface. Implement this interface to provide a custom way of
 * parsing your 'source' fragments.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/SourceParser.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2005/03/23 02:25:13 $ $Name:  $
 */
public interface SourceParser {

    /**
     * Creates a transformer.Source from an input stream.
     * 
     * @param is InputStream with the content of the &lt;source&gt; element.
     * @return transformer.Source
     * @throws Exception
     */
    public abstract Source getSource(InputStream is) throws Exception;

}
