package utfx.framework;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.StringReader;
import java.lang.reflect.InvocationTargetException;
import java.net.URISyntaxException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.DOMConfiguration;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;
import org.xml.sax.SAXException;

import utfx.util.DOMWriter;

/**
 * JUnit extension for testing XSLT stylesheets.
 * <p>
 * Copyright &copy; 2004 - <a href="http://www.usq.edu.au"> University of
 * Southern Queensland. </a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/XSLTTransformTestCase.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido
 * @author Sally MacFarlane
 * @author Alex Daniel
 * @version $Revision$ $Date$ $Name:  $
 */
public class XSLTTransformTestCase extends UTFXTestCase {

    /** XPath factory */
    private XPathFactory xpf;

    /** XPath */
    private XPath xpath;

    /** The name of this test case */
    private String testName;

    /** XSLT transformer used to transform the source */
    private Transformer transformer;

    /** transformer.Source */
    private Source transformSource;

    /** The source input */
    private String sourceString;

    /** The expected output */
    private String expectedString;

    /** The message to output when the assertion fails */
    private String failureMessage;

    private String templateName;

    /** LOG4J logging facility */
    private Logger log;

    /** source builder used to parse utfx:source fragments */
    private SourceParser sourceBuilder;

    /** DOM3 implementation registry */
    private DOMImplementationRegistry domRegistry;

    /** DOM Load/Save implementation */
    private DOMImplementationLS domImplLS;

    /** DOM Load/Save serializer */
    private LSSerializer domSerializer;

    /** DOM Configuration object */
    private DOMConfiguration domConfig;

    private boolean validateSource = false;

    private boolean validateExpected = false;

    private boolean useSourceParser = false;
    
    /** value of href attribute in &lt;utfx:source&gt; */ 
    private ExternalResource externalSourceFile;

    /** value of href attribute in &lt;utfx:expected&gt; */ 
    private ExternalResource externalExpectedFile;

    private String expectedDocType;

    /**
     * We need to flag badly formed tests at assambly time and throw an
     * exception at test run time; this is due to JUnit limitation;
     */
    private MalformedTestException mte = null;

    /** XSLTTestFileSuite that is the parent of this XSLTTransformTestCase */
    private XSLTTestFileSuite parentSuite;

    /**
     * Get the failureMessage. Method used for testing.
     * 
     * @return failureMessage
     */
    public String getFailureMessage() {
        return failureMessage;
    }

    /**
     * Get the <code>useSourceParser</code> value. Method used for testing.
     * 
     * @return true if use-source-parser="yes" is set on &lt;utfx:source&gt;
     */
    public boolean useSourceParser() {
        return useSourceParser;
    }
        
    /**
     * Get the <code>validateExpected</code> value. Method used for testing.
     * 
     * @return false if validate="no" has been set on &lt;utfx:expected&lt; and
     *         true otherwise. NOTE: validate="yes" is the default.
     */
    public boolean validateExpected() {
        return validateExpected;
    }

    /**
     * Get the <code>validateExpected</code> value. Method used for testing.
     * 
     * @return false if validate="no" has been set on &lt;utfx:source&lt; and
     *         true otherwise. NOTE: validate="yes" is the default.
     */
    public boolean validateSource() {
        return validateSource;
    }

    /**
     * Constructs an XsltTestCase.
     * 
     * @param testName
     *            the name of this test
     * @param source
     *            the source input
     * @param expected
     *            the expected output
     * @throws InstantiationException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws NoSuchMethodException
     * @throws ClassNotFoundException
     * @throws XPathExpressionException
     * @throws MalformedTestException
     */
    public XSLTTransformTestCase(Element elem, XSLTTestFileSuite parentSuite)
            throws Exception {

        super("testTransform");
        log = Logger.getLogger("utfx.framework");
        this.templateName = null;
        this.sourceBuilder = parentSuite.getDefaultSourceBuilder();
        this.parentSuite = parentSuite;
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());
        domRegistry = DOMImplementationRegistry.newInstance();
        domImplLS = (DOMImplementationLS) domRegistry
                .getDOMImplementation("LS");
        domSerializer = domImplLS.createLSSerializer();
        domConfig = domSerializer.getDomConfig();
        domConfig.setParameter("xml-declaration", false);

        processNode(elem);
    }

    /**
     * Process utfx:test element and create appropriate test components.
     * 
     * @param testElement
     *            dom.Element representing utfx:test
     * 
     * @throws Exception
     *             upon error.
     */
    private void processNode(Element testElement) throws Exception {

        testName = xpath.evaluate("utfx:name", testElement);
        if (testName == null || "".equals(testName)) {
            testName = "name not set";
        }

        templateName = xpath.evaluate("utfx:call-template/@name", testElement);

        if ("yes".equals(xpath.evaluate(
                "utfx:assert-equal/@normalise-internal-whitespace", testElement))) {
            normaliseInternalWhitespace = true;
        }

        if ("no".equals(xpath.evaluate(
                "utfx:assert-equal/utfx:source/@validate", testElement))
                || !parentSuite.doSourceValidation()) {
            validateSource = false;
        } else {
            validateSource = true;
        }

        if ("no".equals(xpath.evaluate(
                "utfx:assert-equal/utfx:expected/@validate", testElement))
                || !parentSuite.doExpectedValidation()) {
            validateExpected = false;
        } else {
            validateExpected = true;
        }

        if ("yes".equals(xpath
                .evaluate("utfx:assert-equal/utfx:source/@use-source-parser",
                        testElement))) {
            useSourceParser = true;
        }
        
        externalSourceFile = new ExternalResource(getStringFromXpath(testElement,
                "utfx:assert-equal/utfx:source/@href"), parentSuite.getFile());
        externalExpectedFile = new ExternalResource(getStringFromXpath(testElement,
                "utfx:assert-equal/utfx:expected/@href"), parentSuite.getFile());

        if (!isValid(testElement)) {
            return;
        }
        
        try {
            setTestSourceBuilder(testElement);
            setTransformSource(testElement);
            setExpectedString(testElement);
        } catch (Exception e) {
            log.error("failed processing test element(s): ", e);
        }

        failureMessage = xpath.evaluate(".//utfx:message", testElement);

        if (failureMessage == null || "".equals(failureMessage)) {
            failureMessage = "UTF-X test failed";
        }
    }

    /**
     * Set String to null or to value depending on result of XPath
     * 
     * @param testElement
     * @param xpathExpr
     * @return String 
     * @throws XPathExpressionException
     */
    protected String getStringFromXpath(Element testElement, String xpathExpr) throws XPathExpressionException {
        String result;
               
        Object node = xpath.evaluate(xpathExpr, testElement, XPathConstants.NODE);
        if (node == null) {
            result = null;
        } else {
            result = xpath.evaluate(xpathExpr, testElement);
        }

        return result;
    }

    /**
     * Set source builder for this test. If this test does not specify its own
     * source builder then the source builder set by the file test suite will be
     * used.
     * 
     * @param testElement
     *            this UTF-X test as DOM Element.
     * @throws XPathExpressionException
     * @throws ClassNotFoundException
     * @throws NoSuchMethodException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws InstantiationException
     */
    private void setTestSourceBuilder(Element testElement) throws Exception {
        SourceParserFactory sbLoader = new SourceParserFactory();
        Element sbElem = (Element) xpath.evaluate("utfx:source-builder",
                testElement, XPathConstants.NODE);
        if (sbElem != null) {
            sourceBuilder = sbLoader.getSourceParser(sbElem);
        }
    }

    /**
     * Serialize the given node to a String.
     * 
     * @param node
     * @return
     * @throws Exception
     */
    public String serializeNode(Node node) throws Exception {
        ByteArrayOutputStream baos;
        DOMWriter domWriter;
        String result;
        LSOutput lsOutput;
        short nodeType = node.getNodeType();

        // there seems to be a bug with the DOM3 serializer which causes
        // an NPE when serializing empty elements or any non-element node -
        // current workaround is to use the utfx.util.DOMWriter in such cases
        baos = new ByteArrayOutputStream(0x200);

        if ((nodeType == Node.ELEMENT_NODE) && node.hasChildNodes()) {
            lsOutput = domImplLS.createLSOutput();
            lsOutput.setByteStream(baos);
            lsOutput.setEncoding("UTF-8");
            domSerializer.write(node, lsOutput);
        } else {
            log.info("using DOMWriter");
            baos = new ByteArrayOutputStream();
            domWriter = new DOMWriter(baos);
            domWriter.print(node);
        }
        result = baos.toString("UTF8");
        return result;
    }

    /**
     * Set transform.Source object.
     * 
     * @param testElement
     *            dom.Element representing the UTF-X test.
     * @throws Exception
     */
    private void setTransformSource(Element testElement) throws Exception {
        sourceString = generateSourceString(testElement);

        // create a validation test case if required
        if (validateSource) {
            parentSuite.addTest(new XMLValidationTestCase(testName
                    + " [source fragment validation]", sourceString));
        }

        // set transformSource
        if (useSourceParser) {
        	ByteArrayInputStream sourceStream = new ByteArrayInputStream(sourceString.getBytes());
            transformSource = sourceBuilder.getSource(sourceStream);
        } else {
            DefaultSourceParser defaultSourceParser = new DefaultSourceParser();
            // fixing https://utf-x.dev.java.net/issues/show_bug.cgi?id=74 - Two-byte UTF-8 characters in TDFs
            transformSource = defaultSourceParser.getSource(new StringReader(sourceString));
        }
    }

    /**
     * Generate the source string out of testElement
     * 
     * @param testElement
     * @return sourceString
     * @throws XPathExpressionException
     * @throws Exception
     */
    protected String generateSourceString(Element testElement) throws XPathExpressionException, Exception {
        
        Document doc = testElement.getOwnerDocument();        
        Element sourceWrapper = doc.createElement("utfx-wrapper");
        NodeList sourceNodes = generateSourceNodes(testElement);
        
        // append sourceNodes to utfx-wrapper element
        appendNodes(sourceWrapper, sourceNodes);

        // if utfx:source is empty and call-template is used we have to add a
        // second utfx-wrapper element
        if (isUsingCallTemplate() && (sourceNodes.getLength() == 0)) {
            sourceWrapper.appendChild(doc.createElement("utfx-wrapper"));
        }

        return getSourceDocType("utfx-wrapper") + serializeNode(sourceWrapper);
    }

    /**
     * Appends a list of nodes to an element
     * 
     * @param sourceWrapper
     * @param sourceNodes
     */
    private void appendNodes(Element sourceWrapper, NodeList sourceNodes) {
        for (int i = 0; i < sourceNodes.getLength(); i++) {
            Node node = sourceNodes.item(i);
            sourceWrapper.appendChild(node);
        }
    }

    /**
     * Generates a node list from the utfx:source element
     * 
     * Normally the node list is read from the TDF.
     * When using a href it is read from an external file.
     * 
     * @param testElement
     * @return node list
     * @throws XPathExpressionException
     * @throws FileNotFoundException
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     * @throws URISyntaxException 
     */
    protected NodeList generateSourceNodes(Element testElement) throws XPathExpressionException, FileNotFoundException, ParserConfigurationException, SAXException, IOException, URISyntaxException {
        if (externalSourceFile.isAvailable()) {
            return externalSourceFile.getNodes(testElement.getOwnerDocument());
        } else {
            return generateSourceNodesFromTDF(testElement);            
        }
    }

    /**
     * Generates the node list from the TDF
     * 
     * @param testElement
     * @return node list
     * @throws XPathExpressionException
     */
    protected NodeList generateSourceNodesFromTDF(Element testElement) throws XPathExpressionException {
        NodeList sourceNodes = (NodeList) xpath.evaluate(
                "utfx:assert-equal/utfx:source/node()", testElement,
                XPathConstants.NODESET);
        return sourceNodes;
    }

    public Source getTransformSource() {
        return transformSource;
    }
    
    /**
     * @param testElement
     * @throws Exception
     */
    private void setExpectedString(Element testElement) throws Exception {
        expectedDocType = getExpectedDocType("utfx-wrapper");
        expectedString = expectedDocType + generateExpectedString(testElement);

        // create a validation test case if required
        if (validateExpected) {
            parentSuite.addTest(new XMLValidationTestCase(testName
                    + " [expected fragment validation]", expectedString));
        }
    }

    /**
     * Generates the expected string for the test
     * 
     * @param testElement
     * @return expected string
     * @throws Exception
     */
    private String generateExpectedString(Element testElement) throws Exception {
        Document doc = testElement.getOwnerDocument();

        Element expectedWrapper = doc.createElement("utfx-wrapper");
        NodeList expectedNodes = generateExpectedNodes(testElement);
        appendNodes(expectedWrapper, expectedNodes);

        return serializeNode(expectedWrapper);
    }

    /**
     * Generates a node list from utfx:expected depending on whether an external file is in use
     * 
     * @param testElement
     * @return node list
     * @throws XPathExpressionException
     * @throws FileNotFoundException
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     * @throws URISyntaxException 
     */
    private NodeList generateExpectedNodes(Element testElement) throws XPathExpressionException, FileNotFoundException, ParserConfigurationException, SAXException, IOException, URISyntaxException {
        if (externalExpectedFile.isAvailable()) { 
            return externalExpectedFile.getNodes(testElement.getOwnerDocument());
        } else {
            return generateExpectedNodesFromTDF(testElement);            
        }
    }

    /**
     * Generates a node list from utfx:expected from the TDF
     * 
     * @param testElement
     * @return node list
     * @throws XPathExpressionException
     */
    private NodeList generateExpectedNodesFromTDF(Element testElement) throws XPathExpressionException {
        return (NodeList) xpath.evaluate(
                "utfx:assert-equal/utfx:expected/node()", testElement,
                XPathConstants.NODESET);
    }
    
    /**
     * Returns the expectedString of the test (currently only used by JUnit tests)
     * 
     * @return expectedString of test
     */
    public String getExpectedString() {
        return expectedString;
    }
    
    /**
     * Sanity Checks on utfx:test
     * 
     * @param testElement
     * @throws XPathExpressionException
     */
    private boolean isValid(Element testElement) throws XPathExpressionException {

        if (xpath.evaluate(".//utfx:assert-equal", testElement, XPathConstants.NODE) == null) {
            mte = new MalformedTestException("each test must contain at least "
                    + "one <utfx:assert-equal> element");
            return false;
        }
        if (xpath.evaluate(".//utfx:source", testElement, XPathConstants.NODE) == null) {
            mte = new MalformedTestException("required element <utfx:source>"
                    + " is missing");
            return false;
        }
        if (xpath.evaluate(".//utfx:expected", testElement, XPathConstants.NODE) == null) {
            mte = new MalformedTestException("required element <utf:expected>"
                    + " is missing");
            return false;
        }

        return true;

    }

    /**
     * Tests if this is using a named-template transformer.
     */
    public boolean isUsingCallTemplate() {
        return (templateName != null) && (!templateName.equals(""));
    }

    /**
     * Sets the transformer to be used.
     */
    public void setTransformer(Transformer transformer) {
        this.transformer = transformer;
    }

    /**
     * Transforms the source using the transformer and asserts their
     * equivalence. This is the method that is called by the JUnit framework to
     * run the UTF-X test.
     */
    public void testTransform() throws Exception {
        // check if we have a MalformedTestException to throw
        if (mte != null) {
            throw mte;
        }

        log.debug(testName + " :: testTransform()");
        if (transformer == null) {
            fail("No transformer defined for " + testName);
        }

        ByteArrayOutputStream actualOutputStream = new ByteArrayOutputStream();

        transformer.clearParameters();
        transformer.transform(transformSource, new StreamResult(
                actualOutputStream));

        String actualString = "";
        if (expectedDocType != null) {
            actualString = expectedDocType;
        }
        actualString += actualOutputStream.toString("UTF8");

        log.debug("source=[" + sourceString + "]");
        log.debug("actual=[" + actualString + "]");
        log.debug("expected=[" + expectedString + "]");

        assertEquivXML(failureMessage, new ByteArrayInputStream(expectedString
                .getBytes("UTF8")), new ByteArrayInputStream(actualString
                .getBytes("UTF8")));
    }

    /**
     * Generate doctype declaration from root element name, public identifier
     * and system identifier.
     * 
     * @param rootTagName
     * @param publicID
     * @param systemID
     * @return
     */
    private String getDocType(String rootTagName, String publicID,
            String systemID) {
        String doctype = "";

        if (rootTagName == null || publicID == null || systemID == null
                || "".equals(rootTagName) || "".equals(publicID)
                || "".equals(systemID)) {
            return "";
        }

        doctype += "<!DOCTYPE ";
        doctype += rootTagName + " PUBLIC ";
        doctype += "\"" + publicID + "\" ";
        doctype += "\"" + systemID + "\" [ <!ELEMENT utfx-wrapper ANY> ]>\n";

        return doctype;
    }

    private String getSourceDocType(String rootTagName) {
        return getDocType(rootTagName, parentSuite.getSourcePublicId(),
                parentSuite.getSourceSystemId());
    }

    private String getExpectedDocType(String rootTagName) {
        return getDocType(rootTagName, parentSuite.getExpectedPublicId(),
                parentSuite.getExpectedSystemId());
    }

    public String toString() {
        return testName;
    }
    
}