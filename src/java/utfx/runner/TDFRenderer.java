package utfx.runner;

import java.io.File;
import java.io.FileOutputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.apache.xml.resolver.tools.CatalogResolver;
import org.w3c.dom.DOMConfiguration;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

import utfx.framework.UTFXNamespaceContext;

/**
 * Test Definition File renderer. This class generates HTML rendition from TDFs.
 * <p>
 * Copyright &copy; 2005 Jacek Radajewski and others. </a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/runner/TDFRenderer.java,v $
 * </code>
 * 
 * @deprecated this class is no longer used. the original idea was to display
 *             expected rendition in an iframe loading semerate HTML fragments,
 *             but the current XSLT implementation of HTML TDF rendition seems
 *             to do the job OK.
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class TDFRenderer {

    private Logger log;

    private DocumentBuilderFactory dbf;

    private DocumentBuilder db;

    private XPathFactory xpf;

    private XPath xpath;

    /** DOM3 implementation registry */
    private DOMImplementationRegistry domRegistry;

    /** DOM Load/Save implementation */
    private DOMImplementationLS domImplLS;

    /** DOM Load/Save serializer */
    private LSSerializer domSerializer;

    /** DOM Configuration object */
    private DOMConfiguration domConfig;

    private String linkElement;

    public TDFRenderer() throws Exception {
        log = Logger.getLogger("utfx.framework");
        log.info("created");
        dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        db = dbf.newDocumentBuilder();
        db.setEntityResolver(new CatalogResolver());
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());
        domRegistry = DOMImplementationRegistry.newInstance();
        domImplLS = (DOMImplementationLS) domRegistry
                .getDOMImplementation("LS");
        domSerializer = domImplLS.createLSSerializer();
        domConfig = domSerializer.getDomConfig();
        domConfig.setParameter("xml-declaration", false);
    }

    /**
     * 
     * @param doc
     */
    private void processDocument(String filename) throws Exception {
        Document doc = db.parse(filename);
        String dir = (new File(filename)).getParent();
        Element expected;
        NodeList expectedFragments = doc.getElementsByTagNameNS(
                "http://utfx.org/test-definition", "expected");
        String cssURI = xpath.evaluate("//utfx:css/@uri", doc);
        if (!"".equals(cssURI)) {
            linkElement = "<link rel=\"stylesheet\" type=\"text/css\" href=\""
                    + cssURI + "\"/>";
        }
        for (int i = 0; i < expectedFragments.getLength(); i++) {
            expected = (Element) expectedFragments.item(i);
            generateHTML(expected, dir + "/expected" + i + ".html");
        }
    }

    /**
     * 
     * @param expected
     */
    private void generateHTML(Element expected, String filename)
            throws Exception {
        StringBuffer html = new StringBuffer(0x200);
        FileOutputStream fos;
        NodeList nl = (NodeList) xpath.evaluate("./*", expected,
                XPathConstants.NODESET);
        html.append("<html><head>\n" + linkElement + "\n</head><body>\n");
        for (int i = 0; i < nl.getLength(); i++) {
            html.append(domSerializer.writeToString((Node) nl.item(i)));
        }
        html.append("</body></html>\n");
        fos = new FileOutputStream(filename);
        fos.write(html.toString().getBytes());
        fos.close();
        log.info("html = \n" + html);
    }

    /**
     * 
     * @param args
     */
    public static void main(String[] args) throws Exception {
        String tdFilename = args[0];
        TDFRenderer renderer = new TDFRenderer();
        renderer.log.info("Processing " + tdFilename);
        renderer.processDocument(tdFilename);
    }

}
