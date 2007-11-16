package utfx.util;

import java.io.StringWriter;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;

/**
 * Serializiation of javax.xml.transform.Source
 * 
 * <p>
 * Copyright &copy; 2007 UTF-X Development Team.
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
public class SourceSerializer {

    /**
     * Serialize javax.xml.transform.Source to String
     * 
     * @param src
     * @return serialized string
     * @throws TransformerException 
     */
    public String serialize(Source src) throws TransformerException {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer;
        transformer = transformerFactory.newTransformer();
        StringWriter writer = new StringWriter();
        Result result = new StreamResult(writer);
        transformer.transform(src, result);

        return writer.toString();
    }
    
}
