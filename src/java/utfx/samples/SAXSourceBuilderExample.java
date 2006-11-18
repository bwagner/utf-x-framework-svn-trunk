package utfx.samples;

import java.io.InputStream;

import javax.xml.transform.Source;

import org.xml.sax.helpers.DefaultHandler;

import utfx.framework.SourceParser;


/**
 * This is an example of a custom source builder.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/samples/SAXSourceBuilderExample.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2 $ $Date: 2005/03/23 02:37:01 $ $Name:  $
 */
public class SAXSourceBuilderExample extends DefaultHandler implements
        SourceParser {

    /**
     * 
     */
    public SAXSourceBuilderExample() {
        super();
        // TODO Auto-generated constructor stub
    }

    /*
     * (non-Javadoc)
     * 
     * @see au.edu.usq.utfx.framework.SourceBuilder#getSource(java.io.InputStream)
     */
    public Source getSource(InputStream is) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

}
