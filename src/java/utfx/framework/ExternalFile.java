package utfx.framework;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.apache.xml.resolver.tools.CatalogResolver;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.sun.org.apache.xpath.internal.NodeSet;

/**
 * External file referenced by TDF.
 * Used for supporting external files with &lt;utfx:source&gt; and &lt;utfx:expected&gt;.
 * 
 * <p>
 * Copyright &copy; 2007 UTF-X Development Team.
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
 * $Source: $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: $ $Date: $ $Name: $
 */
public class ExternalFile {

    /** LOG4J logging facility */
    private Logger log;

    /** filename of external file */
    private String filename;

    /** filename is relative to this file */
    private File relativeTo;

    /**
     * Constructor
     * 
     * @param filename of external file (can be absolute or relative)
     * @param relativeTo is used when filename is relative
     */
    public ExternalFile(String filename, File relativeTo) {
        super();
        this.log = Logger.getLogger("utfx.framework");
        this.filename = filename;
        this.relativeTo = relativeTo;
    }

    /**
     * Is an external file available
     * 
     * @return boolean
     */
    public boolean isAvailable() {
        return this.filename != null;
    }

    /**
     * Get filename of external file
     * 
     * @return String
     */
    public String getName() {
        if (isAvailable()) {
            return this.filename;            
        } else {
            String msg = "No external file in use";
            log.fatal(msg);
            throw new AssertionError(msg);
        }        
    }

    /**
     * Get path of external file
     * 
     * @return String
     */
    public String getPath() {
        StringBuffer result = new StringBuffer();
        
        if (isAbsolutePath(this.filename)) {
            result.append(this.filename);
        } else {
            result.append(relativeTo.getParent());
            result.append(File.separatorChar);
            result.append(filename);
        }
        
        return result.toString();        
    }

    /**
     * Generates a node list from an external file and copies the nodes to the dstDocument
     * 
     * @param dstDocument
     * @return node list
     * @throws FileNotFoundException
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     */
    public NodeList getNodes(Document dstDocument) throws FileNotFoundException, ParserConfigurationException, SAXException, IOException {
        Document doc = parse(getPath());
        Element el = doc.getDocumentElement();
        Node importedNode = dstDocument.importNode(el, true);
        NodeList nodeList = nodeToNodeList(importedNode);

        return nodeList;        
        
    }
    
    /**
     * Is the filename an absolute path?
     * 
     * @param filename
     * @return boolean
     */
    protected boolean isAbsolutePath(String filename) {
        File file = new File(filename);
        return file.isAbsolute();
    }
    
    /**
     * Creates DOM Tree from file
     * 
     * @param filename
     * @return DOM Document
     * @throws ParserConfigurationException
     * @throws FileNotFoundException
     * @throws SAXException
     * @throws IOException
     */
    protected Document parse(String filepath) throws ParserConfigurationException, FileNotFoundException, SAXException, IOException {
        return parse(new FileInputStream(filepath));
    }

    /**
     * Creates DOM Tree from InputStream
     * 
     * @param inputStream
     * @return DOM Document
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     */
    protected Document parse(InputStream inputStream) throws ParserConfigurationException, SAXException, IOException {
        DocumentBuilder db = createDocumentBuilder();
        return db.parse(inputStream);
    }
    
    /**
     * Converts a single node into a node list
     * 
     * @param node
     * @return node list
     */
    protected NodeList nodeToNodeList(Node node) {
        // create NodeList out of node
        NodeSet nodeSet = new NodeSet();
        nodeSet.addNode(node);
        NodeList nodeList = (NodeList) nodeSet;
        return nodeList;
    }

    /**
     * Create DocumentBuilder with internal DocumentBuilderFactory
     * 
     * @return created DocumentBuilder
     * @throws ParserConfigurationException
     */
    protected DocumentBuilder createDocumentBuilder() throws ParserConfigurationException { 
        return createDocumentBuilder(createDocumentBuilderFactory());
    }
    
    /**
     * Create DocumentBuilder from given DocumentBuilderFactory
     * 
     * @param DocumentBuilderFactory
     * @return created DocumentBuilder
     * @throws ParserConfigurationException
     */
    protected DocumentBuilder createDocumentBuilder(DocumentBuilderFactory dbf) throws ParserConfigurationException {
        DocumentBuilder db;
        db = dbf.newDocumentBuilder();
        db.setEntityResolver(new CatalogResolver());
        return db;
    }
    
    /**
     * Create DOM Document builder factory
     * 
     * @return created DocumentBuilderFactory
     */
    protected DocumentBuilderFactory createDocumentBuilderFactory() {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        dbf.setExpandEntityReferences(false);
        dbf.setValidating(false);
        return dbf;
    }

}
