package utfx.framework;

import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.apache.xml.resolver.tools.CatalogResolver;
import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * Generates the wrapper XSLT stylesheets for executing the tests
 * 
 * <p>
 * Copyright &copy; 2006 UTF-X Development Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/Attic/WrapperStylesheetGenerator.java,v $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: 1.1.2.4 $ $Date: 2006/08/22 14:57:09 $ $Name:  $
 */
public class WrapperStylesheetGenerator {
    /** XPath factory */
    private XPathFactory xpf;

    /** Xpath */
    private XPath xpath;

    /** DOM Document builder factory */
    private DocumentBuilderFactory dbf;

    /** DOM Document builder */
    private DocumentBuilder db;

    /** URI of stylesheet under test */
    String stylesheetUnderTestURI;

    /** log4j logging facility */
    private Logger log;

    /**
     * Construct a new WrapperStylesheetGenerator
     * 
     * @param stylesheetUnderTestURI
     *            Uniform Resource Identifier to the stylesheet under test
     * @throws ParserConfigurationException
     */
    public WrapperStylesheetGenerator(String stylesheetUnderTestURI)
            throws ParserConfigurationException {
        this.stylesheetUnderTestURI = stylesheetUnderTestURI;

        log = Logger.getLogger("utfx.framework");

        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());

        dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        dbf.setExpandEntityReferences(false);
        dbf.setValidating(false);
        db = dbf.newDocumentBuilder();
        db.setEntityResolver(new CatalogResolver());
    }

    /**
     * Get the Uniform Resource Identifier to the stylesheet under test
     * 
     * @return Uniform Resource Identifier to the stylesheet under test
     */
    public String getStylesheetUnderTestURI() {
        return stylesheetUnderTestURI;
    }

    /**
     * Constructs a wrapper document for executing a test
     * 
     * @param testElement
     *            utfx:test element
     * @return wrapper document for executing a test
     * @throws Exception
     */
    public Document getWrapper(Element testElement) throws Exception {
        Document wrapperDoc;
        InputStream xsltInStream = getClass().getResourceAsStream(
                "/xsl/wrapper.xsl");

        try {
            wrapperDoc = db.parse(xsltInStream);
        } catch (Exception e) {
            throw new AssertionError(e);
        }

        try {
            Attr hrefAttr = (Attr) xpath.evaluate("//xsl:import/@href",
                    wrapperDoc, XPathConstants.NODE);
            hrefAttr.setValue(stylesheetUnderTestURI);
        } catch (XPathExpressionException e) {
            throw new AssertionError(e);
        }

        Element stylesheetParamsElement = (Element) xpath.evaluate(
                "utfx:stylesheet-params", testElement, XPathConstants.NODE);
        if (stylesheetParamsElement != null) {
            addStylesheetParams(wrapperDoc, stylesheetParamsElement);
        }

        String sourceContextNode = getSourceContextNode(testElement);
        Element utfxWrapperElement = (Element) xpath.evaluate("//utfx-wrapper",
                wrapperDoc.getDocumentElement(), XPathConstants.NODE);
        Element callTemplateElement = (Element) xpath.evaluate(
                "utfx:call-template", testElement, XPathConstants.NODE);
        if (callTemplateElement == null) {
            addApplyTemplates(wrapperDoc, utfxWrapperElement, sourceContextNode);
        } else {
            addCallTemplate(wrapperDoc, utfxWrapperElement,
                    callTemplateElement, sourceContextNode);
        }

        return wrapperDoc;
    }

    /**
     * Get the content of the context-node attribute of utfx:source element
     * 
     * Empty string is returned when attribute isn't present. When the slash at
     * the beginning of context-node is missing it is added.
     * 
     * @param testElement
     * @return content of the context-node attribute of utfx:source element
     * @throws Exception
     */
    private String getSourceContextNode(Element testElement) throws Exception {
        StringBuffer sourceContextNode = new StringBuffer();

        Element utfxSourceElement = (Element) xpath.evaluate(
                "utfx:assert-equal/utfx:source", testElement,
                XPathConstants.NODE);
        if (utfxSourceElement != null) {
            sourceContextNode.append(utfxSourceElement
                    .getAttribute("context-node"));
            if (sourceContextNode.length() > 0) {
                if (!sourceContextNode.toString().startsWith("/")) {
                    sourceContextNode.insert(0, "/");
                }
            }
        }

        return sourceContextNode.toString();
    }

    /**
     * Adds code for stylesheet parameters to wrapperDoc
     * 
     * @param wrapperDoc
     *            DOM Document representing the UTF-X test definition file.
     * @param elem
     *            stylesheet-params element
     * @return void
     * @throws Exception
     */
    private void addStylesheetParams(Document wrapperDoc, Element elem)
            throws Exception {

        // find refElement (for insertBefore)
        Element xslOutputElement = (Element) xpath.evaluate("xsl:output",
                wrapperDoc.getDocumentElement(), XPathConstants.NODE);
        Node refNode = xslOutputElement.getNextSibling();

        NodeList params;
        try {
            params = (NodeList) xpath.evaluate("*[name() = 'utfx:with-param']",
                    elem, XPathConstants.NODESET);
        } catch (XPathExpressionException e) {
            throw new AssertionError(e);
        }

        for (int i = 0; i < params.getLength(); i++) {
            Element withParamElement = (Element) params.item(i);

            // create xsl:param element
            Element xslParam = wrapperDoc.createElementNS(
                    UTFXNamespaceContext.XSL_NS_URI, "xsl:param");
            xslParam
                    .setAttribute("name", withParamElement.getAttribute("name"));
            copySelectAttrOrChildNodes(withParamElement, wrapperDoc, xslParam);

            wrapperDoc.getDocumentElement().insertBefore(xslParam, refNode);
        }
    }

    /**
     * Adds XSLT-elements for apply-templates to wrapperDoc
     * 
     * creates the element <xsl:apply-templates
     * select="exsl:node-set($utfx-wrapper-removed)/child::node()"/> and appends
     * it to utfxWrapperElement
     * 
     * @param wrapperDoc
     *            DOM Document representing the UTF-X test definition file
     * @param utfxWrapperElement
     *            the utfx-wrapper element from wrapper.xsl
     */
    private void addApplyTemplates(Document wrapperDoc,
            Element utfxWrapperElement, String sourceContextNode) {
        // compose select expression for xsl:apply-templates
        StringBuffer selectExpression = new StringBuffer(
                "exsl:node-set($utfx-wrapper-removed)");
        if (sourceContextNode.length() == 0) {
            selectExpression.append("/child::node()");
        } else if (sourceContextNode.equals("/")) {
            log.error("when using context-node=\"/\" for template match an infinite recursion will happen");
            // adding a slash to exsl:node-set($utfx-wrapper-removed) would
            // result in an invalid XPath expression. therefore we don't add
            // anything
        } else {
            selectExpression.append(sourceContextNode);
        }

        Element xslApplyTemplates = wrapperDoc.createElementNS(
                UTFXNamespaceContext.XSL_NS_URI, "xsl:apply-templates");
        xslApplyTemplates.setAttribute("select", selectExpression.toString());

        utfxWrapperElement.appendChild(xslApplyTemplates);
    }

    /**
     * Adds XSLT-elements for calling a named template to wrapperDoc
     * 
     * Following elements are added to utfxWrapperElement as childs
     * <xsl:for-each select="exsl:node-set($utfx-wrapper-removed)/*[1]"> or
     * context-node attribute <xsl:call-template name="NAME OF TEMPLATE"/>
     * </xsl:for-each> <xsl:apply-templates
     * select="exsl:node-set($utfx-wrapper-removed)/*[position() > 1]"/>
     * 
     * @param wrapperDoc
     *            DOM Document representing the UTF-X test definition file
     * @param utfxWrapperElement
     *            the utfx-wrapper element from wrapper.xsl
     * @param elem
     *            call-template element
     * @return void
     * @throws Exception
     */
    private void addCallTemplate(Document wrapperDoc,
            Element utfxWrapperElement, Element elem, String sourceContextNode)
            throws Exception {
        String templateName = elem.getAttribute("name");

        Element xslCallTemplate = wrapperDoc.createElementNS(
                UTFXNamespaceContext.XSL_NS_URI, "xsl:call-template");
        xslCallTemplate.setAttribute("name", templateName);
        addCallTemplateParameters(wrapperDoc, elem, xslCallTemplate);

        // compose select expression for xsl:for-each
        StringBuffer selectExpression = new StringBuffer(
                "exsl:node-set($utfx-wrapper-removed)");
        if (sourceContextNode.length() == 0) {
            selectExpression.append("/*[1]");
        } else if (sourceContextNode.equals("/")) {
            // adding a slash to exsl:node-set($utfx-wrapper-removed) would
            // result in an invalid XPath expression. therefore we don't add
            // anything
        } else {
            selectExpression.append(sourceContextNode);
        }

        Element xslForEach = wrapperDoc.createElementNS(
                UTFXNamespaceContext.XSL_NS_URI, "xsl:for-each");
        xslForEach.setAttribute("select", selectExpression.toString());
        xslForEach.appendChild(xslCallTemplate);

        Element xslApplyTemplates = wrapperDoc.createElementNS(
                UTFXNamespaceContext.XSL_NS_URI, "xsl:apply-templates");
        xslApplyTemplates.setAttribute("select",
                "exsl:node-set($utfx-wrapper-removed)/*[position() > 1]");

        utfxWrapperElement.appendChild(xslForEach);
        utfxWrapperElement.appendChild(xslApplyTemplates);
    }

    /**
     * Adds with-param elements to wrapperDoc
     * 
     * @param wrapperDoc
     *            DOM Document representing the UTF-X test definition file.
     * @param elem
     *            stylesheet-params element
     * @param xslCallTemplate
     *            call-template element in wrapperDoc
     * @return void
     */
    private void addCallTemplateParameters(Document wrapperDoc, Element elem,
            Element xslCallTemplate) {
        NodeList params;

        try {
            params = (NodeList) xpath.evaluate("*[name() = 'utfx:with-param']",
                    elem, XPathConstants.NODESET);
        } catch (XPathExpressionException e) {
            throw new AssertionError(e);
        }

        int paramsCount = params.getLength();

        for (int i = 0; i < paramsCount; i++) {
            Element paramElem = (Element) params.item(i);

            Element xslWithParam = wrapperDoc.createElementNS(
                    UTFXNamespaceContext.XSL_NS_URI, "xsl:with-param");

            String name = paramElem.getAttribute("name");
            xslWithParam.setAttribute("name", name);

            copySelectAttrOrChildNodes(paramElem, wrapperDoc, xslWithParam);
            xslCallTemplate.appendChild(xslWithParam);
        }
    }

    /**
     * Copies the select attribute if available or its childnodes to destination
     * element
     * 
     * @param src
     *            source element
     * @param doc
     *            destination document
     * @param dst
     *            destination element
     * @return void
     */
    private void copySelectAttrOrChildNodes(Element src, Document doc,
            Element dst) {
        String selectAttrName = "select";
        if (src.hasAttribute(selectAttrName)) {
            dst.setAttribute(selectAttrName, src.getAttribute(selectAttrName));
        } else {
            importAndAppendChildNodes(src, doc, dst);
        }
    }

    /**
     * Copies childnodes to destination element
     * 
     * @param src
     *            source element
     * @param doc
     *            destination document
     * @param dst
     *            destination element
     * @return void
     */
    private void importAndAppendChildNodes(Element src, Document doc,
            Element dst) {
        NodeList childNodes = src.getChildNodes();

        for (int j = 0; j < childNodes.getLength(); j++) {
            Node node = childNodes.item(j);
            Node importedNode = doc.importNode(node, true);
            dst.appendChild(importedNode);
        }
    }

}
