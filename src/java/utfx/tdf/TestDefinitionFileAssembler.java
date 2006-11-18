package utfx.tdf;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.util.HashMap;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.DOMConfiguration;
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;
import org.w3c.dom.DocumentFragment;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

import utfx.framework.UTFXNamespaceContext;

/**
 * This class assembles TestDefinitionFile objects from XML files.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/tdf/TestDefinitionFileAssembler.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2006/07/29 19:46:36 $ $Name:  $
 */
public class TestDefinitionFileAssembler {

    /** Logging facility */
    private Logger log;

    /** URI from which this TDF is created */
    private String uri;

    /** DOM Document Builder factory */
    private DocumentBuilderFactory dbf;

    /** DOM Document builder (parser) */
    private DocumentBuilder db;

    /** DOM Document representation of this TDF */
    private Document tdfDoc;

    /** Schema factory */
    private SchemaFactory schemaFactory;

    /** test definition file W3C schema */
    private Schema tdfSchema;

    private XPathFactory xpf;

    private XPath xpath;

    private TransformerFactory tf;

    private Transformer transformer;

    private HashMap<String, Document> xmlDocuments;

    /** DOM3 implementation registry */
    private DOMImplementationRegistry domRegistry;

    /** DOM Load/Save implementation */
    private DOMImplementationLS domImplLS;

    private DOMImplementation domImpl;

    /** DOM Load/Save serializer */
    private LSSerializer domSerializer;

    /** DOM Configuration object */
    private DOMConfiguration domConfig;

    private TestDefinitionFile tdf;

    /**
     * Construct a new TDF from a URI
     * 
     * @param uri
     */
    public TestDefinitionFileAssembler(String uri) throws Exception {
        this.uri = uri;
        tf = TransformerFactory.newInstance();
        tdf = new TestDefinitionFile();
        log = Logger.getLogger(this.getClass());
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());
        domRegistry = DOMImplementationRegistry.newInstance();
        domImpl = domRegistry.getDOMImplementation("XML 3.0");
        domImplLS = (DOMImplementationLS) domRegistry
                .getDOMImplementation("LS");
        domSerializer = domImplLS.createLSSerializer();
        domConfig = domSerializer.getDomConfig();
        tdfDoc = parse();
        tdfDoc.getDomConfig().setParameter("canonical-form", false);
        assemble();
    }

    /**
     * @return
     * @throws Exception
     */
    private Document parse() throws Exception {
        Source schemaSource;
        schemaFactory = SchemaFactory
                .newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        schemaSource = new StreamSource(ClassLoader
                .getSystemResourceAsStream("xsd/tdf.xsd"));
        tdfSchema = schemaFactory.newSchema(schemaSource);

        dbf = DocumentBuilderFactory.newInstance();
        log.info("DBF Implementation is " + dbf.getClass());
        log.info("Class loader: " + dbf.getClass().getClassLoader());
        dbf.setNamespaceAware(true);
        // turn off legacy DTD validation
        dbf.setValidating(false);
        dbf.setSchema(tdfSchema);
        db = dbf.newDocumentBuilder();
        log.info("pparsing " + uri);
        return db.parse(uri);
    }

    /**
     * 
     *
     */
    private void assemble() throws Exception {
        NodeList docList;
        DOMSource domSource;
        StreamResult result;
        ByteArrayOutputStream baos;
        Document newDoc;
        DocumentFragment frag;
        docList = (NodeList) xpath.evaluate("//tdf:xml-document", tdfDoc,
                XPathConstants.NODESET);
        log.info("got " + docList.getLength() + " xml-document's");

        loadStylesheet();
        Node node;
        NodeList children;
        for (int i = 0; i < docList.getLength(); i++) {
            children = docList.item(i).getChildNodes();
            log.info("created new document");
            frag = tdfDoc.createDocumentFragment();
            log.info("created document fragment, assembling nodes...");

            for (int j = 0; j < children.getLength(); j++) {
                frag.appendChild(children.item(j).cloneNode(true));
                log.info("appending node " + children.item(j));
            }

            log.info("fragment is : " + domSerializer.writeToString(frag));
            domSource = new DOMSource(frag);
            baos = new ByteArrayOutputStream(0x100);
            result = new StreamResult(baos);
            log.info("transforming: " + frag);
            transformer.transform(domSource, result);
            log.info("result was: " + baos);
        }
            /*
             * xpathResult = (Node) xpath.evaluate(".//root-element", docList
             * .item(i), XPathConstants.NODE); log.info("xpath result is of type " +
             * xpathResult.getClass()); log.info("serialised form: " +
             * domSerializer.writeToString(xpathResult)); baos = new
             * ByteArrayOutputStream(0x100); result = new StreamResult(baos);
             * docSource = new DOMSource(docList.item(i));
             * log.info("transforming: " + docList.item(i));
             * transformer.transform(docSource, result); log.info("result was: " +
             * baos);
             */
    }

    /**
     * Retrieves the uri pointing to the XSLT stylesheet, builds a transformer
     * and sets the transformer on the TestDefinitionFile object.
     * 
     * @throws Exception
     */
    private void loadStylesheet() throws Exception {
        String stylesheetUri = xpath.evaluate("//tdf:stylesheet/@src", tdfDoc);
        Source xsltSource = new StreamSource(new FileInputStream(stylesheetUri));
        transformer = tf.newTransformer(xsltSource);
        tdf.setTransformer(transformer);
        log.info("transformer created");

    }

    /**
     * Loads XML documents defined in the TDF.
     */
    private void loadDocuments() {

    }

    /**
     * Factory method.
     * 
     * @param uri
     * @return
     * @throws Exception
     */
    public static TestDefinitionFile newTestDefinitionFile(String uri)
            throws Exception {
        TestDefinitionFileAssembler me = new TestDefinitionFileAssembler(uri);
        return null;
    }

    public static void main(String args[]) throws Exception {
        TestDefinitionFile tdf = TestDefinitionFileAssembler
                .newTestDefinitionFile(args[0]);
    }

}