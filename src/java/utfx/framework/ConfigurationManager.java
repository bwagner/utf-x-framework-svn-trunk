package utfx.framework;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

import utfx.printers.AnsiColourResultPrinter;
import utfx.printers.FormattedResultPrinter;
import utfx.printers.JunitResultPrinter;

/**
 * UTF-X framework configuration manager.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/ConfigurationManager.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$Date: 2006/08/22 04:59:44 $ $ $Name:  $
 */
public class ConfigurationManager {

    /** name of the properties file */
    private static final String propertiesFilename = "utfx.properties";

    /** singleton instance of the ConfigurationManager */
    private static ConfigurationManager instance;

    /** UTF-X properties */
    private Properties utfxProperties;

    /** logger */
    private Logger log;

    /** operating system * */
    private String osName;

    /**
     * create the singleton instance of the ConfigurationManager and load
     * properties.
     */
    static {
        instance = new ConfigurationManager();
    }

    /**
     * Create a new instance of ConfigurationManager. This constructor is
     * private and should never be called from outside this class.
     */
    private ConfigurationManager() {
        super();
        utfxProperties = new Properties();
        log = Logger.getLogger("utfx.framework");
        osName = System.getProperty("os.name");
        log.debug("OS name is: " + osName);

        try {
            InputStream is = new FileInputStream(propertiesFilename);
            utfxProperties.load(is);
        } catch (Exception e) {
            log.error("Problem loading '" + propertiesFilename + "' ", e);
        }
    }

    /**
     * @return an instance of the ConfigurationManager singleton.
     */
    public static ConfigurationManager getInstance() {
        return instance;
    }

    /**
     * This methods creates and returns java.io.FilenameFilter used for
     * filtering UTF-X test definition files. The filter class name is obtained
     * from the <code>utfx.testfile-filter.class</code> property. If the class
     * cannot be loaded or the instance cannot be created then a default test
     * file filter will be used. The default test file filter is TestFileFilter.
     * 
     * @return FilenameFilter
     * @see TestFileFilter
     */
    public FilenameFilter getTestFileFilter() {
        String testFileFilterClassName = "not set";
        Class testFileFilterClass;
        FilenameFilter filter;

        try {
            testFileFilterClassName = utfxProperties
                    .getProperty("utfx.testfile-filter.class");
            testFileFilterClass = Class.forName(testFileFilterClassName);
            filter = (FilenameFilter) testFileFilterClass.newInstance();

        } catch (Exception e) {
            log.warn("unable to create test file filter '"
                    + testFileFilterClassName + "'.  Trying default");

            // will use the default
            testFileFilterClass = TestFileFilter.class;

            try {
                filter = (FilenameFilter) testFileFilterClass.newInstance();
            } catch (Exception fe) {
                log.fatal("failed creating default filename filter", fe);
                throw new AssertionError(
                        "failed creating default filename filter");
            }
        }
        return filter;
    }

    /**
     * @return default SourceParser. This SourceParser will be used throughout
     *         the test run unles overwritten test file suite or test case level
     *         (in UTF-X test definition files).
     */
    public SourceParser getSourceBuilder() {
        String className = "not set";
        Class clazz;
        SourceParser sb;

        try {
            className = utfxProperties.getProperty("utfx.source-builder.class");
            clazz = Class.forName(className);
            sb = (SourceParser) clazz.newInstance();

        } catch (Exception e) {
            log.warn("unable to create transform source builder '" + className
                    + "'.  Trying default");

            // will use the default
            clazz = DefaultSourceParser.class;

            try {
                sb = (SourceParser) clazz.newInstance();
            } catch (Exception fe) {
                log.fatal("failed creating default transform source builder",
                        fe);
                throw new AssertionError(
                        "failed creating default transform source builder");
            }
        }
        return sb;
    }

    /**
     * Get a ResultPrinter Class object for the result printer as specified in
     * the <code>utfx.result-printer.class</code> property. If the property is
     * not set then return a default ResultPrinter, ie JunitResultPrinter
     * 
     * @return a result printer class
     * @see JunitResultPrinter
     */
    public Class getResultPrinterClass() {
        String resultPrinterClassName = "not set";
        Class resultPrinterClass;
        try {
            resultPrinterClassName = utfxProperties
                    .getProperty("utfx.result-printer.class");
            resultPrinterClass = Class.forName(resultPrinterClassName);
        } catch (Exception e) {
            log.warn("unable to create result printer class '"
                    + resultPrinterClassName + "'.  Trying default");

            // will use default ResultPrinter
            // ANSICoulourResult printer for Linux platforms
            // FormattedResultPrinter for other platforms
            if ("linux".equals(osName.toLowerCase())) {
                resultPrinterClass = AnsiColourResultPrinter.class;
            } else {
                resultPrinterClass = FormattedResultPrinter.class;
            }
        }
        return resultPrinterClass;
    }

    /**
     * @return result printer outout stream
     * @throws FileNotFoundException
     *             if the file specified in the properties file cannot be
     *             created
     */
    public OutputStream getResultPrinterOutputStream()
            throws FileNotFoundException {
        String resultPrinterFilename = utfxProperties
                .getProperty("utfx.result-printer.output-file");
        if (resultPrinterFilename == null) {
            return System.out;
        } else {
            return new FileOutputStream(resultPrinterFilename);
        }
    }

    /**
     * Check if HTML report of the test run should be generrated.
     * 
     * @return true iff property <code>utfx.html-report.generate=yes</code>
     */
    public boolean generateHTMLReport() {
        if ("yes".equals(utfxProperties
                .getProperty("utfx.html-report.generate"))) {
            return true;
        }
        return false;
    }

    /**
     * @return the name of the file into which the HTML report should be written
     *         to. This filename is obtained from the
     *         <code>utfx.html-report.filename</code> property.
     */
    public String getHTMLReportFilename() {
        return utfxProperties.getProperty("utfx.html-report.filename");
    }

    /**
     * Check if UTF-X should attempt to open the generated HTML report in a browser.
     * 
     * @return true iff property <code>utfx.html-report.open-in-browser=yes</code>
     */
    public boolean openHTMLReportInBrowser() {
        if ("yes".equals(utfxProperties
                .getProperty("utfx.html-report.open-in-browser"))) {
            return true;
        }
        return false;
    }

}