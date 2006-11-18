package utfx.testgen;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import utfx.util.DOMWriter;

/**
 * This class builds utfx:source and utfx:expected fragments.
 * <p>
 * Copyright &copy; 2006 UTF-X Development Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/testgen/SourceExpectedBuilder.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2.2.1 $ $Date: 2006/08/21 16:35:54 $ $Name:  $
 */
public class SourceExpectedBuilder {

    /** XPath factory */
    private XPathFactory xpf;

    /** XPath */
    private XPath xpath;

    /** document representing the XSLT stylesheet */
    private Document xmlDoc;

    /** transformer representing the stylesheet */
    private Transformer transformer;

    public Document getXmlDoc() {
        return xmlDoc;
    }

    public void setXmlDoc(Document xmlDoc) {
        this.xmlDoc = xmlDoc;
    }

    /**
     * Construct a new SourceExpectedBuilder object.
     * 
     * @param
     */
    public SourceExpectedBuilder(Transformer transformer) {
        this.transformer = transformer;
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
    }

    /**
     * @param elementName
     * @return
     */
    public String getSource(String elementName) throws Exception {
        NodeList nl;
        DOMWriter dw;
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        dw = new DOMWriter(baos);

        if (xmlDoc == null
                || elementName
                        .equals(xmlDoc.getDocumentElement().getNodeName())) {
            return "<" + elementName + "/>";
        }
        nl = (NodeList) xpath.evaluate("//" + elementName, xmlDoc,
                XPathConstants.NODESET);

        if (nl.getLength() != 0) {
            dw.print(nl.item(0));
            return new String(baos.toByteArray());
        } else {
            return "<" + elementName + "/>";
        }
    }

    /**
     * @param elementName
     * @return
     */
    public String getExpected(String elementName) throws Exception {
        StreamSource ss;
        StreamResult sr;
        ByteArrayOutputStream baos;
        String sourceContent = getSource(elementName);
        ss = new StreamSource(
                new ByteArrayInputStream(sourceContent.getBytes()));
        baos = new ByteArrayOutputStream();
        sr = new StreamResult(baos);
        transformer.transform(ss, sr);
        return new String(baos.toByteArray());
    }

}
