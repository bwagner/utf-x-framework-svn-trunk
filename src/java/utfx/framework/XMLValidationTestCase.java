package utfx.framework;

import java.io.ByteArrayInputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import junit.framework.TestCase;

import org.apache.log4j.Logger;
import org.apache.xml.resolver.tools.CatalogResolver;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * Validation Test Case. This test case uses a DOM validating parser to parse
 * the document and reports any warnings, errors and fatal error using the
 * weblogic logging facility. Please see the <a
 * href="http://www.w3.org/TR/REC-xml#sec-terminology">Extensible Markup
 * Language (XML) 1.0 (Second Edition) </a> W3C recommendation for a full
 * definition of <code>error</code> and <code>fatal
 * error</code>.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/XMLValidationTestCase.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido (Lulu)
 * @version $Revidion:$ $Date$ $Name:  $
 */
public class XMLValidationTestCase extends TestCase implements ErrorHandler {

    /** document builder factory */
    private DocumentBuilderFactory dbf;

    /** document builder */
    private DocumentBuilder db;

    /** logging facility */
    private Logger log;
    
    /** name of this test */
    private String testName;
    
    /** this is where we log validation errors */
    private StringBuffer errors;
    
    /** the XML content we are to validate */
    private String xml;
    
    /** true iff the xml content is valid */
    private boolean isValid;

    /**
     * Construct a new XML Validator from a URI pointing to an XML doc.
     * 
     * @param is the XML document to be validated, as an input stream
     */
    public XMLValidationTestCase(String testName, String xml) {

        super("validate"); // the test method for this test case
        this.testName = testName;
        this.xml = xml;
        this.isValid = true; // start with valid and mark false upon error
        log = Logger.getLogger("utfx.framework");
        dbf = DocumentBuilderFactory.newInstance();
        dbf.setValidating(true);
        try {
            db = dbf.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            // TODO please fix me
            e.printStackTrace();
        }
            
        db.setEntityResolver(new CatalogResolver());
        db.setErrorHandler(this);
        errors = new StringBuffer(0xFF);
    }

    /**
     * Handle parse error.
     * 
     * @param e instance of SAXParserException containing the details of the
     *        error.
     * @throws SAXException.
     */
    public void error(SAXParseException e) throws SAXException {
        int l, c;
        l = e.getLineNumber();
        c = e.getColumnNumber();
        isValid = false;
        if(!"".equals(errors.toString())) { errors.append("\n"); }
        errors.append("[line " + l + ", col " + c + "]: " + e.getMessage());
        log.debug("[line " + l + ", col " + c + "]: " + e.getMessage());        
    }

    /**
     * Handle warning but take no further action.
     * 
     * @param e instance of SAXParserException containing the details of the
     *        warning.
     * @throws SAXException.
     */
    public void warning(SAXParseException e) throws SAXException {
        int l, c;
        l = e.getLineNumber();
        c = e.getColumnNumber();
        if(!"".equals(errors.toString())) { errors.append("\n"); }        
        log.debug("[line " + l + ", col " + c + "]: " + e.getMessage());
    }

    /**
     * Handle fatal error.
     * 
     * @param e instance of SAXParserException containing the details of the
     *        error.
     * @throws SAXException.
     */
    public void fatalError(SAXParseException e) throws SAXException {
        int l, c;
        l = e.getLineNumber();
        c = e.getColumnNumber();
        isValid = false;
        if(!"".equals(errors.toString())) { errors.append("\n"); }        
        errors.append("[line " + l + ", col " + c + "]: " + e.getMessage());
        log.debug("[line " + l + ", col " + c + "]: " + e.getMessage());
    }

    /**
     * Perform validation.
     */
    public void validate() throws Exception {

        log.debug("validating " + testName + " ...");
        log.debug("vcalidating\n" + xml);
        db.parse(new ByteArrayInputStream(xml.getBytes("UTF-8")));
        log.debug(testName + " done");
        
        if (!isValid) {
            throw new XMLValidationError(errors.toString());
        }
    }
    
    public String toString() {
        return testName;
    }

}