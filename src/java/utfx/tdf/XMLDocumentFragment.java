package utfx.tdf;

import org.w3c.dom.DocumentFragment;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * Represents an XML document fragment declared inside a test definition file.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/tdf/XMLDocumentFragment.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class XMLDocumentFragment {

    /** DOM Node representing this XML document */
    private Node node;

    /**
     * Document fragment containing the nodes which represent the content. This
     * fragment is built from all the children of the Node passed to the
     * cunstructor
     */
    private DocumentFragment content;

    /**
     * Creates a new XML document from a DOM Node. 
     * @param node
     *            DOM Node
     */
    public XMLDocumentFragment(Node node) {
	this.node = node;
    }

    /**
     * @param xpathExpression
     * @return
     */
    public Node selectNodes(String xpathExpression) {
	return null;
    }

    /**
     * @return serilised, String representation of the content.
     */
    public String toString() {
	return "";
    }

}
