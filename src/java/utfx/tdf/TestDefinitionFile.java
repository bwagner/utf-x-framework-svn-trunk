package utfx.tdf;

import java.util.HashMap;

import javax.xml.transform.Transformer;

import org.w3c.dom.DocumentFragment;

/**
 * This class represents the UTF-X test definition file.
 * <p>
 * Copyright &copy; 2006 - UTF-X development team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/tdf/TestDefinitionFile.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2006/07/29 19:46:35 $ $Name:  $
 */
public class TestDefinitionFile {
    
    private Transformer transformer;
    
    private HashMap<String, DocumentFragment> documents;
    
    public HashMap<String, DocumentFragment> getDocuments() {
        return documents;
    }

    public void setDocuments(HashMap<String, DocumentFragment> documents) {
        this.documents = documents;
    }

    public Transformer getTransformer() {
        return transformer;
    }

    public void setTransformer(Transformer transformer) {
        this.transformer = transformer;
    }

    public TestDefinitionFile() {
        super();
    }
    
}
