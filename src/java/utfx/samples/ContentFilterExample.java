package utfx.samples;

import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import utfx.framework.SourceParser;


/**
 * This is an example of a custom DOM-based source builder. This source builder
 * acts as a simple XML pre-processor filtering content based on the output
 * attribute value. In small applications this would be done in the XSLT
 * stylesheet it self, but the author has worked on significant publishing
 * systems where such filtering involved complex business logic including
 * database lookups. XSLT is not really suitable for business rules processing.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/samples/ContentFilterExample.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2 $ $Date: 2005/03/23 02:36:04 $ $Name:  $
 */
public class ContentFilterExample implements SourceParser {

    /** document builder factory */
    private DocumentBuilderFactory dbf;

    /** document builder */
    private DocumentBuilder db;

    /** output type eg. web or print */
    private String desiredTarget;

    /**
     * Construct a new ContentFilterExample.
     */
    public ContentFilterExample(String outputType) {
        this.desiredTarget = outputType;
    }

    /**
     * (non-Javadoc)
     * 
     * @see utfx.framework.SourceParser#getSource(java.io.InputStream)
     */
    public Source getSource(InputStream is) throws Exception {
        Document doc;
        DOMSource source;

        dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(false);
        db = dbf.newDocumentBuilder();
        doc = db.parse(is);
        processNode(doc);
        source = new DOMSource(doc);

        return source;
    }

    /**
     * Recursevely process the dom node removing elements attributes with
     * attributes that don't match the desired output.
     * 
     * @param node DOM node to process.
     */
    private void processNode(Node node) {
        Node child;
        NodeList nl;
        nl = node.getChildNodes();
        for (int i=0; i<nl.getLength(); i++) {
            child = nl.item(i);
            if (child.getNodeType() == Node.ELEMENT_NODE) {
                filterElement((Element) child);
            }
            processNode(child);
        }
    }
    
    /**
     * 
     * @param e
     */
    private void filterElement(Element e) {
        String elementTarget;
        elementTarget = e.getAttribute("target");
        if (!desiredTarget.equals(elementTarget)) {
            e.getParentNode().removeChild(e);
        }
    }

}
