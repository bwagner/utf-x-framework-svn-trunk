package utfx.util;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import org.w3c.dom.Attr;
import org.w3c.dom.DocumentType;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * DOMWriter.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/util/DOMWriter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido (Lulu)
 * @version $Revidion:$ $Date$ $Name:  $
 */
public class DOMWriter {

    /** Encoding of the printWriter we are using */
    private static String ENCODING = "UTF-8";

    // private static String ENCODING = "ISO-8859-1";

    /** The print writer to output the DOM document */
    private PrintWriter out;

    /** True to strip white space surrounding elements */
    private boolean stripWhiteSpace;

    /** True to escape single and double quote characters */
    private boolean escapeQuoteCharacters;

    /**
     * Creates a DOMWriter for pretty printing the DOM.
     * 
     * @param os The output stream to write the XML to
     */
    public DOMWriter(OutputStream os) throws Exception {
        this(os, false);
    }

    /**
     * Creates a DOMWriter for pretty printing the DOM.
     * 
     * @param os The output stream to write the XML to
     * @param strip True to strip the white space surrounding elements
     */
    public DOMWriter(OutputStream os, boolean strip) throws Exception {
        this(os, strip, true);
    }

    /**
     * Creates a DOMWriter for pretty printing the DOM.
     * 
     * @param os The output stream to write the XML to
     * @param stripWhiteSpace True to strip the white space surrounding elements
     * @param escapeQuoteCharacters True to escape single and double quote
     *        characters
     */
    public DOMWriter(OutputStream os, boolean stripWhiteSpace,
            boolean escapeQuoteCharacters) throws Exception {
        // specify UTF8 encoding for the output stream writer
        OutputStreamWriter osw = new OutputStreamWriter(
                new BufferedOutputStream(os), ENCODING);

        out = new PrintWriter(osw);
        this.stripWhiteSpace = stripWhiteSpace;
        this.escapeQuoteCharacters = escapeQuoteCharacters;

    }

    /**
     * Prints any node in the DOM including the Document Element and any Doctype
     * elements, recursively calls it self to print child elements.
     * 
     * @param node the node to start printing from (usually the root).
     */
    public void print(Node node) {

        // is there anything to do?
        if (node == null) {
            return;
        }

        int type = node.getNodeType();

        switch (type) {
        case Node.DOCUMENT_NODE: {
            out
                    .println("<?xml version=\"1.0\" encoding=\"" + ENCODING
                            + "\"?>");

            // Process all the children
            NodeList children = node.getChildNodes();
            for (int iChild = 0; iChild < children.getLength(); iChild++) {
                print(children.item(iChild));
            }
            out.flush();
            break;
        }

        case Node.DOCUMENT_TYPE_NODE: {
            out.print("<!DOCTYPE " + node.getNodeName());
            DocumentType docType = (DocumentType) node;
            if (docType.getPublicId() != null) {
                out.print(" PUBLIC \"" + docType.getPublicId() + "\"");
            } else {
                out.print(" SYSTEM ");
            }
            if (docType.getSystemId() != null) {
                out.print(" \"" + docType.getSystemId() + "\"");
            }

            // Process all the children
            NodeList children = node.getChildNodes();
            for (int iChild = 0; iChild < children.getLength(); iChild++) {
                print(children.item(iChild));
            }
            out.println(">");
            out.flush();
            break;
        }

        // print opening element with attributes
        case Node.ELEMENT_NODE: {
            out.print('<');
            out.print(node.getNodeName());
            Attr attrs[] = sortAttributes(node.getAttributes());
            for (int i = 0; i < attrs.length; i++) {
                Attr attr = attrs[i];
                out.print(' ');
                out.print(attr.getNodeName());
                out.print("=\"");
                // attribute values will have all XML characters escaped
                out.print(normalize(attr.getNodeValue(), true));
                out.print('"');
            }
            out.print('>');
            NodeList children = node.getChildNodes();
            if (children != null) {
                int len = children.getLength();
                for (int i = 0; i < len; i++) {
                    print(children.item(i));
                }
            }
            break;
        }

        case Node.ENTITY_NODE: {
            break;
            //
        }
        // handle entity reference nodes
        case Node.ENTITY_REFERENCE_NODE: {
            out.print('&');
            out.print(node.getNodeName());
            out.print(';');
            break;
        }

        // print cdata sections
        case Node.CDATA_SECTION_NODE: {
            out.print("<![CDATA[");
            out.print(node.getNodeValue());
            out.print("]]>");
            break;
        }

        // print text
        case Node.TEXT_NODE: {
            String value = node.getNodeValue();
            if (stripWhiteSpace) {
                value = value.trim();
            }
            // text nodes will have some or all XML characters escaped
            out.print(normalize(value, escapeQuoteCharacters));
            break;
        }

        // print comment
        case Node.COMMENT_NODE: {
            out.print("<!--");
            String data = node.getNodeValue();
            if (data != null && data.length() > 0) {
                out.print(data);
            }
            out.println("-->");
            break;
        }

        // print processing instruction
        case Node.PROCESSING_INSTRUCTION_NODE: {
            out.print("<?");
            out.print(node.getNodeName());
            String data = node.getNodeValue();
            if (data != null && data.length() > 0) {
                out.print(' ');
                out.print(data);
            }
            out.println("?>");
            break;
        }
        } // End switch statement

        // Print the element closing tag as this is a leaf node
        // or all of the children have been processed
        if (type == Node.ELEMENT_NODE) {
            out.print("</");
            out.print(node.getNodeName());
            out.print('>');
        }

        out.flush();

    } // print(Node)

    /**
     * Converts characters to their appropriate XML entity reference. The
     * characters <, >, and & will be escaped within text nodes and attribute
     * values. The characters " and ' will be escaped within text nodes only if
     * escapeQuoteCharacters is set to true, otherwise they will be output as
     * is. The characters " and ' will be escaped within attribute values,
     * regardless of the value of escapeQuoteCharacters.
     * 
     * @param s the string to normalize
     * @param escapeQuoteCharacters whether to escape quote characters
     */
    protected String normalize(String s, boolean escapeQuoteCharacters) {

        StringBuffer str = new StringBuffer();

        int len = (s != null) ? s.length() : 0;
        for (int i = 0; i < len; i++) {
            char ch = s.charAt(i);
            switch (ch) {
            case '<': {
                str.append("&lt;");
                break;
            }
            case '>': {
                str.append("&gt;");
                break;
            }
            case '&': {
                str.append("&amp;");
                break;
            }
            case '"': {
                if (escapeQuoteCharacters) {
                    str.append("&quot;");
                } else {
                    str.append(ch);
                }
                break;
            }
            case '\'': {
                if (escapeQuoteCharacters) {
                    str.append("&apos;");
                } else {
                    str.append(ch);
                }
                break;
            }
            default: {
                str.append(ch);
            }
            }
        }

        return (str.toString());

    } // normalize(String):String

    /**
     * Sorts element attributes into alphabetical order I dont know why this is
     * necessary.
     */
    protected Attr[] sortAttributes(NamedNodeMap attrs) {

        int len = (attrs != null) ? attrs.getLength() : 0;
        Attr array[] = new Attr[len];
        for (int i = 0; i < len; i++) {
            array[i] = (Attr) attrs.item(i);
        }
        for (int i = 0; i < len - 1; i++) {
            String name = array[i].getNodeName();
            int index = i;
            for (int j = i + 1; j < len; j++) {
                String curName = array[j].getNodeName();
                if (curName.compareTo(name) < 0) {
                    name = curName;
                    index = j;
                }
            }
            if (index != i) {
                Attr temp = array[i];
                array[i] = array[index];
                array[index] = temp;
            }
        }

        return (array);

    } // sortAttributes(NamedNodeMap):Attr[]
}
