package utfx.framework;

import java.io.InputStream;

import javax.xml.transform.Source;
import javax.xml.transform.sax.SAXSource;

import org.apache.xml.resolver.tools.CatalogResolver;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 * Default implementation of the SourceParser interface. This implementation
 * uses a SAX parser.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/DefaultSourceParser.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2 $ $Date: 2006/08/01 07:39:30 $ $Name:  $
 */
public class DefaultSourceParser implements SourceParser {

    /**
     * create a new DefaultSourceParser
     */
    public DefaultSourceParser() {
        super();
    }

    /**
     * @see utfx.framework.SourceParser#getSource(java.io.InputStream)
     */
    public Source getSource(InputStream inStream) throws Exception {
        InputSource inSource;
        SAXSource saxSource;
        XMLReader xmlReader;
        CatalogResolver cr;

        cr = new CatalogResolver();
        xmlReader = XMLReaderFactory.createXMLReader();
        xmlReader.setEntityResolver(cr);
        inSource = new InputSource(inStream);
        saxSource = new SAXSource(xmlReader, inSource);

        return saxSource;
    }

}
