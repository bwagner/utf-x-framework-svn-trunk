package utfx.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;

import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXNotRecognizedException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.ext.LexicalHandler;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

import sax.helpers.AttributesImpl;

/**
 * Transforms an XML document into its canonical form according to the W3C <a
 * href="http://www.w3.org/TR/xml-c14n">Canonical XML </a> specification. This
 * class also has a mode which removes whitespace outside of an element and
 * whitespace in an element if it is only whitespace.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/util/CanonicalForm.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido (Lulu)
 * @version $Revision$ $Date$ $Name:  $
 */
public class CanonicalForm extends DefaultHandler implements LexicalHandler {

    /** Default parser name. */
    protected static final String DEFAULT_PARSER_NAME = "org.apache.xerces.parsers.SAXParser";

    /** Print writer. */
    protected PrintWriter fOut;

    /** Element depth. */
    protected int elementDepth;

    /** SAX Parser. */
    protected XMLReader parser;

    /** Set true to use W3C specification. */
    protected boolean useW3CSpec;

    /**
     * True to put trailing new lines, false for preceding new lines. This
     * applies to comments and processing instructions when using W3C
     * specifications.
     */
    protected boolean trailingNewLine;

    /**
     * Set true when character data is being accumulated into a buffer. This is
     * necessary since SAX does not guarantee that contiguous text is passed in
     * a single characters() method call.
     */
    protected boolean accumulating;

    /** whether we are within an entity */
    protected boolean inEntity;

    /** Buffer where character data is accumulated */
    protected StringBuffer characterData;

    /**
     * if this is set to true than any sequence of white space characters ('\n',
     * '\r', '\t' or ' ') inside an element is converted into a single space
     * character. See <a
     * href="https://utf-x.dev.java.net/issues/show_bug.cgi?id=62">issue 62</a>
     * for more details. NOTE: Whitespace normalisation inside an element is NOT
     * part of the Canonical XML 1.0 and it is a UTF-X specific extension.
     */
    protected boolean normaliseInternalWhitespace = false;

    /** log4j loggin facility */
    private Logger log;

    /**
     * Default constructor.
     * 
     * @deprecated do not use this constructor as it sets useW3Cspec to 'false'.
     */
    public CanonicalForm() {
        this(false);
    }

    /**
     * Constructs a CanonicalForm.
     * 
     * @param useW3CSpec
     *            true to use the W3C Canonical XML spec, set to false so that
     *            whitespace between elements is considered insignificant.
     *            Default is false.
     */
    public CanonicalForm(boolean useW3CSpec) {
        log = Logger.getLogger("utfx.framework");
        this.useW3CSpec = useW3CSpec;
        // create the SAX parser
        try {
            setParserAndHandlers(this);
            setDefaultFeatures();
        } catch (Exception e) {
            log.error("Unable to instantiate parser (" + DEFAULT_PARSER_NAME
                    + ")", e);
        }
    }

    /**
     * @return true iff this CanonicalForm object has been set to nromalise
     *         whitespace inside element. See <a
     *         href="https://utf-x.dev.java.net/issues/show_bug.cgi?id=62">issue
     *         62</a>
     */
    public boolean isNormaliseWhitespace() {
        return normaliseInternalWhitespace;
    }

    /**
     * Sets the normaliseWhitespace flag.
     * 
     * @param normaliseInternalWhitespace
     *            boolean value specifying if the whitespace inside elements
     *            should be normalised: true if whitespace inside elements is to
     *            be normalise, false otherwise. See <a
     *            href="https://utf-x.dev.java.net/issues/show_bug.cgi?id=62">issue
     *            62</a>
     */
    public void setNormaliseWhitespace(boolean normaliseInternalWhitespace) {
        this.normaliseInternalWhitespace = normaliseInternalWhitespace;
    }

    /**
     * set the various handlers to the handler passed in
     */
    protected void setParserAndHandlers(DefaultHandler handler)
            throws Exception {

        parser = XMLReaderFactory.createXMLReader(DEFAULT_PARSER_NAME);
        parser.setContentHandler(handler);
        parser.setErrorHandler(handler);
        parser.setEntityResolver(handler);
        parser.setDTDHandler(handler);
        parser.setProperty("http://xml.org/sax/properties/lexical-handler",
                handler);
    }

    /**
     * Set the XML parser features for Canonical XML.
     */
    protected void setDefaultFeatures() throws SAXException {
        try {
            // do not output any external DTDs

            parser.setFeature("http://xml.org/sax/features/"
                    + "external-general-entities", false);

            parser.setFeature("http://xml.org/sax/features/"
                    + "external-parameter-entities", false);

            parser.setFeature("http://apache.org/xml/features/nonvalidating/"
                    + "load-dtd-grammar", true);

            parser.setFeature("http://apache.org/xml/features/nonvalidating/"
                    + "load-external-dtd", false);

            parser.setFeature("http://apache.org/xml/features/scanner/"
                    + "notify-builtin-refs", false);

            // parser.setFeature("http://xml.org/sax/features/namespaces",
            // false);

            parser.setFeature("http://xml.org/sax/features/validation", false);

            parser.setFeature("http://apache.org/xml/features/validation/"
                    + "schema", false);

            parser.setFeature("http://apache.org/xml/features/validation/"
                    + "schema-full-checking", false);

        } catch (SAXNotRecognizedException snre) {
            log.error("Unknown feature: ", snre);
            snre.printStackTrace();
        }
    }

    /**
     * Transform an XML input stream into its canonical XML form.
     * 
     * @param is
     *            input stream representing an XML document.
     * @param os
     *            output stream which contains the canonical form
     */
    public void transform(InputStream is, OutputStream os) throws IOException,
            SAXException {

        setOutputStream(os);
        parser.parse(new InputSource(is));
    }

    /**
     * Sets the output stream for printing.
     * 
     * @param stream
     *            an <code>OutputStream</code> to which the output will be
     *            printed.
     */
    public void setOutputStream(OutputStream stream) {
        try {
            Writer writer = new OutputStreamWriter(stream, "UTF8");
            fOut = new PrintWriter(writer);
        } catch (UnsupportedEncodingException uee) {
            log.error("Unsupported encoding", uee);
        }
    }

    /** Start document. */
    public void startDocument() {
        elementDepth = 0;
        trailingNewLine = true;
        accumulating = false;
    }

    /** End document. */
    public void endDocument() {
        // nothing to do here
    }

    /** Processing instruction. */
    public void processingInstruction(String target, String data)
            throws SAXException {

        if (useW3CSpec && !trailingNewLine) {
            fOut.print('\n');
        }
        fOut.print("<?");
        fOut.print(target);
        if (data != null && data.length() > 0) {
            fOut.print(' ');
            fOut.print(data);
        }
        fOut.print("?>");
        if (useW3CSpec && trailingNewLine && elementDepth == 0) {
            fOut.print('\n');
        }
        fOut.flush();
    }

    /**
     * Default Implementation of start element.
     * 
     * @param uri
     *            a <code>String</code> value
     * @param local
     *            a <code>String</code> value
     * @param raw
     *            a <code>String</code> value
     * @param attrs
     *            an <code>Attributes</code> value
     * @exception SAXException
     *                if an error occurs
     */
    public void startElement(String uri, String local, String raw,
            Attributes attrs) throws SAXException {

        outputCharacterData();

        elementDepth++;
        if (elementDepth > 0) {
            trailingNewLine = true;
        }

        fOut.print('<');
        fOut.print(raw);
        if (attrs != null) {
            attrs = sortAttributes(attrs);
            for (int i = 0; i < attrs.getLength(); i++) {
                fOut.print(' ');
                fOut.print(attrs.getQName(i));
                fOut.print("=\"");
                normalizeAndPrint(attrs.getValue(i));
                fOut.print('"');
            }
        }
        fOut.print('>');
        fOut.flush();
    }

    /** Characters. */
    public void characters(char ch[], int start, int length)
            throws SAXException {

        String content = new String(ch, start, length);

        if (!accumulating) {
            accumulating = true;
            characterData = new StringBuffer();
        }

        if (!inEntity) {
            characterData.append(content);
        }
    }

    /** Ignorable whitespace. */
    public void ignorableWhitespace(char ch[], int start, int length)
            throws SAXException {
        outputCharacterData();
    }

    /** End element. */
    public void endElement(String uri, String local, String raw)
            throws SAXException {

        outputCharacterData();

        elementDepth--;
        if (elementDepth == 0) {
            trailingNewLine = false;
        }
        fOut.print("</");
        fOut.print(raw);
        fOut.print('>');
        fOut.flush();
    }

    //
    // ErrorHandler methods
    //

    /** Warning. */
    public void warning(SAXParseException ex) throws SAXException {
        outputCharacterData();
        printError("Warning", ex);
    }

    /** Error. */
    public void error(SAXParseException ex) throws SAXException {
        outputCharacterData();
        printError("Error", ex);
    }

    /** Fatal error. */
    public void fatalError(SAXParseException ex) throws SAXException {
        outputCharacterData();
        printError("Fatal Error", ex);
        throw ex;
    }

    //
    // LexicalHandler methods
    //

    /** Start DTD. */
    public void startDTD(String name, String publicId, String systemId)
            throws SAXException {
        outputCharacterData();
    }

    /** End DTD. */
    public void endDTD() throws SAXException {
        outputCharacterData();
    }

    /** Start entity. */
    public void startEntity(String name) throws SAXException {
        // entities are resolved as the DTD declaration is removed,
        // thus causing consequent transformations to fail

        outputCharacterData();
        fOut.print("&" + name + ";");
        accumulating = false;
        inEntity = true;
    }

    /** End entity. */
    public void endEntity(String name) throws SAXException {

        outputCharacterData();
        // accumulating = true;
        inEntity = false;
    }

    /** Start CDATA section. */
    public void startCDATA() throws SAXException {
        outputCharacterData();
    }

    /** End CDATA section. */
    public void endCDATA() throws SAXException {
        outputCharacterData();
    }

    /** Comment. */
    public void comment(char ch[], int start, int length) throws SAXException {
        outputCharacterData();

        if (useW3CSpec && !trailingNewLine) {
            fOut.print('\n');
        }

        fOut.print("<!--");
        fOut.print(new String(ch, start, length));
        fOut.print("-->");

        if (useW3CSpec && trailingNewLine && elementDepth == 0) {
            fOut.print('\n');
        }

        fOut.flush();
    }

    //
    // Protected methods
    //

    /** Returns a sorted list of attributes. */
    protected Attributes sortAttributes(Attributes attrs) {

        AttributesImpl attributes = new AttributesImpl();

        int len = (attrs != null) ? attrs.getLength() : 0;
        for (int i = 0; i < len; i++) {
            String name = attrs.getQName(i);
            int count = attributes.getLength();
            int j = 0;
            while (j < count) {
                if (name.compareTo(attributes.getQName(j)) < 0) {
                    break;
                }
                j++;
            }
            attributes.insertAttributeAt(j, name, attrs.getType(i), attrs
                    .getValue(i));
        }

        return attributes;
    }

    /** Normalizes and prints the given string. */
    protected void normalizeAndPrint(String s) {
        int len = (s != null) ? s.length() : 0;
        boolean inInternalWhitespace = false;
        char c;

        // implementation logic: internal hitespace normalisation has four different
        // states which change while processing the string inside the for loop.
        // The list below describes each state together with the required
        // action. The notation used here uses 'c' for non-whitespace
        // characters, and 's' for white space characters. Second character is
        // the one being processed in this iteration, whilst the first character
        // is the one preceding the current character. This logic only applies
        // when the normaliseWhietspace attribute is set to true.
        // state 1: cs - don't print anything
        // state 2: cc - print character 'c'
        // state 3: sc - print space ' ' character folllowed by character 'c'
        // state 4: ss - don't print anything

        for (int i = 0; i < len; i++) {
            c = s.charAt(i);
            if (normaliseInternalWhitespace) {
                if (c == 0x9 || c == 0xA || c == 0xD || c == 0x20) {
                    // states 1 and 4
                    // don't print whitespace characters
                    inInternalWhitespace = true;
                } else {
                    if (inInternalWhitespace) {
                        // state 3
                        // there was one or more whitespace character preceding
                        // this character so we print a single space character.
                        normalizeAndPrint(' ');
                    } else {
                        // state 2
                    }
                    normalizeAndPrint(c);
                    inInternalWhitespace = false;
                }
            } else { // do not normalise whitespace inside elements
                normalizeAndPrint(c);
            }
        }
    }

    /**
     * Normalizes and prints the given array of characters. If the class
     * variable 'normaliseWhitespace' is to 'true' then this method also
     * performs whitespace normalisation.
     */
    protected void normalizeAndPrint(char[] ch, int offset, int length) {
        boolean inWhitespace = false;
        char c;

        for (int i = 0; i < length; i++) {
            c = ch[offset + i];
            if (normaliseInternalWhitespace) {
                if (c == 0x9 || c == 0xA || c == 0xD || c == 0x20) {
                    inWhitespace = true;
                    // don't print whitespace characters
                } else {
                    if (!inWhitespace) {
                        normalizeAndPrint(" ");
                        normalizeAndPrint(c);
                    }
                    inWhitespace = false;
                }
            } else { // do not normalise whitespace inside elements
                normalizeAndPrint(c);
            }
        }
    }

    /** Normalizes and print the given character. */
    protected void normalizeAndPrint(char c) {
        switch (c) {
        case '<':
            fOut.print("&lt;");
            break;
        case '>':
            fOut.print("&gt;");
            break;
        case '&':
            fOut.print("&amp;");
            break;
        case '"':
            fOut.print("&quot;");
            break;
        case '\r':
            fOut.print('\n');
            break;
        default:
            fOut.print(c);
            break;
        }
    }

    /** Prints the error message. */
    protected void printError(String type, SAXParseException ex) {

        StringBuffer err = new StringBuffer(50);
        String systemId = ex.getSystemId();

        err.append("[" + type + "] ");
        if (systemId != null) {
            int index = systemId.lastIndexOf('/');
            if (index != -1) {
                systemId = systemId.substring(index + 1);
            }
            err.append(systemId);
        }
        err.append(':');
        err.append(ex.getLineNumber());
        err.append(':');
        err.append(ex.getColumnNumber());
        err.append(": ");
        err.append(ex.getMessage());
        err.append(" ");

        log.error(err.toString());
    }

    /**
     * Outputs any character data that was being accumulated in the characters
     * method. This should be called for every SAX event or the data may not be
     * output to its proper location.
     */
    protected void outputCharacterData() {
        String content;

        if (accumulating) {
            content = characterData.toString();
            if (!useW3CSpec) {
                content = content.trim();
            }
            if (content.length() > 0) {
                normalizeAndPrint(content);
            }
        }

        accumulating = false;
    }
}