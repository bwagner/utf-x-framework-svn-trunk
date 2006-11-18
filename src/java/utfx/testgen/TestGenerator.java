package utfx.testgen;

import static java.lang.System.err;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.apache.xml.resolver.tools.CatalogResolver;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import utfx.framework.UTFXNamespaceContext;

/**
 * UTFX test definition file generator. This class generates UTFX test
 * definition file skeleton from an XSLT stylesheet.
 * <p>
 * Copyright &copy; 2005 USQ, Jacek Radajewski and others.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/testgen/TestGenerator.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class TestGenerator {

    /** XPath factory */
    private XPathFactory xpf;

    /** XPath */
    private XPath xpath;

    /** document representing the XSLT stylesheet */
    private Document xsltDoc;

    /** generated test definition skeleton */
    private StringBuffer td;

    /** document builder factory */
    private DocumentBuilderFactory dbf;

    /** document builder */
    private DocumentBuilder db;

    /** log4j logger */
    private Logger log;

    // various options
    /** should generated tests be commented out? */
    private boolean commentOutTest = false;

    /** name of the stylesheet file we are to process */
    private File xsltFile;

    /** name of the test definition file we are to generate */
    private String testFileName;

    /** transformer factory */
    private TransformerFactory tf;

    /** transformer representing the stylesheet */
    private Transformer transformer;

    private boolean force = false;

    private String sampleXMLFilename;

    private SourceExpectedBuilder seb;

    public boolean isForce() {
        return force;
    }

    public void setForce(boolean force) {
        this.force = force;
    }

    public String getSampleXMLFilename() {
        return sampleXMLFilename;
    }

    public void setSampleXMLFilename(String sampleXMLFilename) {
        this.sampleXMLFilename = sampleXMLFilename;
    }

    /**
     * Construct a new test generator.
     * 
     * @param stylesheetFileName
     *            name of the stylesheet for which we are to generate the test
     *            definition file skeleton.
     */
    public TestGenerator(String stylesheetFileName) {
        log = Logger.getLogger("utfx.test_generator");
        log.info("Generating UTF-X Test Definition File for "
                + stylesheetFileName);
        xsltFile = new File(stylesheetFileName);
        testFileName = getTestFilename();
    }

    /**
     * Get the name of the test definition filename based on the name of the
     * stylesheet. This method also creates a test directory under the
     * stylesheet directory.
     * 
     * @param stylesheetFilename
     *            name of the stylesheet file for which we are generating the
     *            test.
     * @return name of the test definition file
     */
    public String getTestFilename() {
        File testFile;
        String xsltPath = xsltFile.getName();
        String testFilename = xsltPath.substring(0, xsltPath.lastIndexOf('.'));
        try {
            testFilename = xsltFile.getParentFile().getCanonicalPath()
                    + "/test/" + testFilename + "_test.xml";
        } catch (IOException e) {
            log.error("failed ????", e);
        }
        testFile = new File(testFilename);
        File testDir = testFile.getParentFile();
        if (!testDir.exists()) {
            if (testDir.mkdir()) {
                log.info("Created test directory " + testDir);
            } else {
                log.error("failed to create test directory " + testDir);
            }
        } else {
            log.info("directory exists " + testDir);
        }
        return testFile.getAbsolutePath();
    }

    /**
     * Process the stylesheet and generate tests.
     * 
     * @throws ParserConfigurationException
     * @throws SAXException
     * @throws IOException
     * @throws TransformerException
     */
    private void process() throws Exception {
        Element template;
        StreamSource xsltSource;
        tf = TransformerFactory.newInstance();
        xsltSource = new StreamSource(new FileInputStream(xsltFile));
        transformer = tf.newTransformer(xsltSource);
        seb = new SourceExpectedBuilder(transformer);
        transformer.setOutputProperty(OutputKeys.METHOD, "xml");
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
        td = new StringBuffer(0xFFF);
        dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        dbf.setValidating(false);
        db = dbf.newDocumentBuilder();
        db.setEntityResolver(new CatalogResolver());
        if (sampleXMLFilename != null) {
            seb.setXmlDoc(db.parse(sampleXMLFilename));
        }
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());
        xsltDoc = db.parse(xsltFile);
        NodeList templates = xsltDoc.getElementsByTagNameNS(
                "http://www.w3.org/1999/XSL/Transform", "template");
        log.info("found " + templates.getLength() + " templates");
        addHeader();
        for (int i = 0; i < templates.getLength(); i++) {
            template = (Element) templates.item(i);
            addTest(template);
        }
        td.append("</utfx:tests>\n");
    }

    private void addHeader() {
        td.append("<?xml version='1.0' encoding='utf-8'?>\n");
        td.append("<!DOCTYPE utfx:tests PUBLIC "
                + "\"-//UTF-X//DTD utfx-tests 1.0//EN\" \"utfx_tests.dtd\">\n");
        td
                .append("<utfx:tests xmlns:utfx=\"http://utfx.org/test-definition\">\n");
        td.append("  <utfx:stylesheet src=\"" + xsltFile.getName() + "\" />\n");
    }

    /**
     * Add a test skeleton to the test definition file.
     * 
     * @param template
     *            the template from which the test skeleton will be generated.
     * @throws TransformerException
     */
    private void addTest(Element template) throws Exception {

        String name; // content of the name attribute (if any)
        String match; // content of the match attribute (if any)

        try {
            name = xpath.evaluate("./@name", template);
            match = xpath.evaluate("./@match", template);
        } catch (Exception e) {
            log.fatal("xpath problem?", e);
            throw new AssertionError(e);
        }

        // a template can have a match attribute and a name attribute
        // see http://www.w3.org/TR/xslt#named-templates
        // code for named template is generated when name attribute is present
        boolean namedTemplate = !"".equals(name);

        td.append("\n  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                + "~~~~~~~~~~~~~~~~~~~~~ -->\n");
        td.append("  <!-- test for ");
        if (namedTemplate) {
            td.append("named ");
        }
        td.append("template ");
        if (namedTemplate) {
            td.append(name);
        } else {
            td.append(match);
        }
        td.append(" -->\n");
        td.append("  <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
                + "~~~~~~~~~~~~~~~~~~~ -->\n");

        if (!namedTemplate) {
            log.info("generating test definition for template " + match);
        } else {
            log.info("generating test definition for named template " + name);
        }

        if (commentOutTest) {
            td.append("<!--\n");
        }

        td.append("  <utfx:test>\n");
        td.append("    <utfx:name>generated test skeleton for ");
        if (namedTemplate) {
            td.append("named template '" + name);
        } else {
            td.append("match template '" + match);
        }
        td.append("'</utfx:name>\n");
        if (namedTemplate) {
            addCallTemplate(template, name);
        }
        td.append("      <utfx:assert-equal>\n");
        td.append("        <utfx:source>\n");
        if (!namedTemplate && isValidElementName(match)) {
            td.append("          " + seb.getSource(match) + "\n");
        }
        td.append("        </utfx:source>\n");
        td.append("        <utfx:expected>\n");

        if (!namedTemplate && isValidElementName(match)) {
            td.append("          " + seb.getExpected(match));
        }
        td.append("        </utfx:expected>\n");
        td.append("      </utfx:assert-equal>\n");
        td.append("  </utfx:test>\n");

        if (commentOutTest) {
            td.append("-->\n");
        }
    }

    /**
     * Adds utfx:call-template elements with utfx:with-param elements
     * 
     * @param template
     */
    private void addCallTemplate(Element template, String name) {
        NodeList params;
        try {
            params = (NodeList) xpath.evaluate("./xsl:param", template,
                    XPathConstants.NODESET);
        } catch (Exception e) {
            log.fatal("xpath problem?", e);
            throw new AssertionError(e);
        }
        boolean hasParams = params.getLength() > 0;

        td.append("      <utfx:call-template name=\"" + name + "\"");
        if (!hasParams) {
            td.append("/>\n");
        } else {
            td.append(">\n");

            for (int i = 0; i < params.getLength(); i++) {
                Element paramElement = (Element) params.item(i);

                String paramName = paramElement.getAttribute("name");
                td.append("        <utfx:with-param name=\"" + paramName
                        + "\"/>\n");
            }

            td.append("      </utfx:call-template>\n");
        }

    }

    /**
     * This method checks if the passed string is a valid XML name. Validation
     * is <b>NOT</b> done based on the 'Name' production as defined in
     * 'Extensible Markup Language (XML) 1.0 (Third Edition) W3C Recommendation,
     * 04 February 2004.' See 'BaseChar production and you'll understand why :)
     * <br/> Validation is done based on a simple regular expression.
     * 
     * @param elementName
     * @return
     */
    public static boolean isValidElementName(String elementName) {

        Pattern p;
        Matcher m;

        p = Pattern.compile("[a-zA-Z][\\-a-zA-Z0-9]*");
        m = p.matcher(elementName);

        return m.matches();
    }

    /**
     * Write the generated test skeleton into a file. Only write the file if it
     * does not exist.
     * 
     * @throws IOException
     */
    private void writeFile() throws IOException {
        FileOutputStream fos;
        File testFile = new File(testFileName);
        log.info("Writing generated test definition to " + testFileName);
        if (!force && testFile.exists()) {
            throw new IOException("file " + testFileName + " already exists. "
                    + "Please remove first or use "
                    + " -f to force the exsisting file to be overwritten.");
        }
        fos = new FileOutputStream(testFileName);
        fos.write(td.toString().getBytes());
        fos.flush();
        fos.close();
    }

    /**
     * Print usage.
     */
    private static void printUsage() {
        err.println("Usage:");
        err
                .println("java -cp build/jar/utfx.jar utfx.testgen.TestGenerator "
                        + "-xslt some_xslt_stylesheet.xsl [-xml sample_xml_document.xml]\n");
        err.println("The generated test skeleton "
                + "file name will be of the format ");
        err.println("some_xslt_stylesheet_test.xml");
        err
                .println("\n-xml samples_xml_document.xml is optional.  If a sample XML");
        err
                .println("document is passed to TestGenerator then the generated test definition");
        err.println("file will be more meaningful.");
    }

    /**
     * @param args
     * @throws SAXException
     * @throws IOException
     * @throws ParserConfigurationException
     */
    public static void main(String[] args) {

        TestGenerator tg;

        String stylesheetFilename = null;

        String sampleXMLFilename = null;

        boolean force = false;

        if (args.length < 1) {
            printUsage();
            System.exit(1);
        }

        for (int i = 0; i < args.length; i++) {
            if ("-f".equals(args[i])) {
                force = true;
            } else if ("-xslt".equals(args[i])) {
                stylesheetFilename = args[++i];
            } else if ("-xml".equals(args[i])) {
                sampleXMLFilename = args[++i];
            }
        }

        if (stylesheetFilename == null) {
            printUsage();
            System.exit(1);
        }

        try {
            tg = new TestGenerator(stylesheetFilename);
            tg.setSampleXMLFilename(sampleXMLFilename);
            tg.setForce(force);
            tg.process();
            tg.writeFile();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}