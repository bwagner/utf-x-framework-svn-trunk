package utfx.framework;

import java.io.File;

import org.apache.log4j.Logger;

import junit.framework.TestSuite;

/**
 * Suite of tests for XSLT stylesheets. This class represents a test suite of
 * UTF-X tests defined in a single definition file.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/XSLTTestFileSuite.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @author Oliver Lucido
 * @author Sally MacFarlane
 * @version $Revision: 1.4.2.1 $ $Date: 2006/08/11 14:23:57 $ $Name:  $
 */
public class XSLTTestFileSuite extends TestSuite {

    private String sourcePublicId;

    private String sourceSystemId;

    private String expectedPublicId;

    private String expectedSystemId;

    /** logger */
    private static Logger log = Logger.getLogger("utfx.framework");

    /** utf-x test definition file */
    private File file;

    /** default source builder for this test suite */
    private SourceParser defaultSourceBuilder;

    /**
     * @return true iff source validation was specified for the test definition
     *         file represented by this object.
     */
    public boolean doSourceValidation() {
        if ("".equals(sourcePublicId) && "".equals(sourceSystemId)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * @return true iff source validation was specified for the test definition
     *         file represented by this object.
     */
    public boolean doExpectedValidation() {
        if ("".equals(expectedPublicId) && "".equals(expectedSystemId)) {
            return false;
        } else {
            return true;
        }
    }
    
    
    /**
     * @return Returns the expectedPublicId.
     */
    public String getExpectedPublicId() {
        return expectedPublicId;
    }

    /**
     * @param expectedPublicId The expectedPublicId to set.
     */
    public void setExpectedPublicId(String expectedPublicId) {
        this.expectedPublicId = expectedPublicId;
    }

    /**
     * @return Returns the expectedSystemId.
     */
    public String getExpectedSystemId() {
        return expectedSystemId;
    }

    /**
     * @param expectedSystemId The expectedSystemId to set.
     */
    public void setExpectedSystemId(String expectedSystemId) {
        this.expectedSystemId = expectedSystemId;
    }

    /**
     * @return Returns the sourcePublicId.
     */
    public String getSourcePublicId() {
        return sourcePublicId;
    }

    /**
     * @param sourcePublicId The sourcePublicId to set.
     */
    public void setSourcePublicId(String sourcePublicId) {
        this.sourcePublicId = sourcePublicId;
    }

    /**
     * @return Returns the sourceSystemId.
     */
    public String getSourceSystemId() {
        return sourceSystemId;
    }

    /**
     * @param sourceSystemId The sourceSystemId to set.
     */
    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId;
    }

    /**
     * Constructs an XSLT test suite with a specified name.
     * 
     * @param dirName where to look for the tests. doubles as the name of this
     *        test suite.
     */
    public XSLTTestFileSuite(String testFilename) {
        super(testFilename);
        ConfigurationManager cm = ConfigurationManager.getInstance();
        defaultSourceBuilder = cm.getSourceBuilder();
        this.file = new File(testFilename);
        setName(file.getName());
    }

    /**
     * Parses an XML test definition document and creates a TestSuite.
     * 
     * @param testFilename the UTF-X test definition file.
     * @return a TestSuite for the test definition
     */
    public static TestSuite suite(String testFilename) {
        TestSuite testSuite = new TestSuite();
        
        try {
            TestFileSuiteAssembler assembler = new TestFileSuiteAssembler(
                testFilename);
            assembler.assemble();
            testSuite = assembler.getTestSuite();
        } catch (MalformedStylesheetException mse) {
            testSuite.addTest(new BadTDFTestCase(testFilename + " : "
                    + mse.getMessage()));
            log.error("Could not create a file suite from "
                    + testFilename, mse);
        } catch (Exception e) {
            testSuite.addTest(new BadXSLTTestCase(testFilename + " : "
                    + e.getMessage()));                
            log.error("Could not create a file suite from "
                    + testFilename, e);                
        }

        return testSuite;
    }

    /**
     * Set default SourceParser to be used by this file TestSuite.
     * 
     * @param defaultSourceBuilder
     */
    public void setDefaultSourceBuilder(SourceParser defaultSourceBuilder) {
        this.defaultSourceBuilder = defaultSourceBuilder;
    }

    /**
     * @return current default SourceParser.
     */
    public SourceParser getDefaultSourceBuilder() {
        return defaultSourceBuilder;
    }
}