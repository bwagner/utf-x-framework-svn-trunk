package utfx.framework;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.xml.namespace.NamespaceContext;

/**
 * Handles namespace context for the UTF-X framework.
 * 
 * <p>
 * Copyright &copy; 2004-2006 - UTF-X development team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/UTFXNamespaceContext.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.5 $ $Date: 2006/07/14 20:32:28 $ $Name:  $
 */
public class UTFXNamespaceContext implements NamespaceContext {

    /** XSL namespace URI */
    public static final String XSL_NS_URI = "http://www.w3.org/1999/XSL/Transform";

    /** OLD UTF-X namespace URI */
    public static final String UTFX_NS_URI = "http://utfx.org/test-definition";

    /** NEW UTF-X TDF namespace URI */
    public static final String TDF_NS_URI = "http://utf-x.sourceforge.net/xsd/tdf_1_0/tdf.xsd";
    
    /** prefix/namespace uri pair storage */
    private HashMap<String, String> map;

    /** create and initilise a new NSContext instance */
    public UTFXNamespaceContext() {
        map = new HashMap<String, String>(0xf);
        map.put("xsl", XSL_NS_URI);
        map.put("utfx", UTFX_NS_URI);
        map.put("tdf", TDF_NS_URI);
    }

    /**
     * @see javax.xml.namespace.NamespaceContext#getNamespaceURI(java.lang.String)
     */
    public String getNamespaceURI(String prefix) {
        return map.get(prefix);
    }

    /**
     * @see javax.xml.namespace.NamespaceContext#getPrefix(java.lang.String)
     */
    public String getPrefix(String namespaceURI) {
        Set<String> keys = map.keySet();

        for (String prefix : keys) {
            if (namespaceURI.equals(getNamespaceURI(prefix))) {
                return prefix;
            }
        }
        return null;
    }

    /*
     * @see javax.xml.namespace.NamespaceContext#getPrefixes(java.lang.String)
     */
    public Iterator getPrefixes(String namespaceURI) {
        List<String> prefixes = new ArrayList<String>();
        Set<String> keys = map.keySet();

        for (String prefix : keys) {
            if (namespaceURI.equals(getNamespaceURI(prefix))) {
                prefixes.add(prefix);
            }
        }
        return prefixes.iterator();

    }

}