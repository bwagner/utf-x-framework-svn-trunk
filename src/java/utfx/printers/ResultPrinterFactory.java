package utfx.printers;

import java.io.FileOutputStream;
import java.io.PrintStream;
import java.lang.reflect.Constructor;

import utfx.framework.ConfigurationManager;


/**
 * ResultPrinter factory.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/ResultPrinterFactory.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$Date: 2006/03/17 23:34:37 $ $ $Name:  $
 */
public class ResultPrinterFactory {

    /** stdout print stream */
    static PrintStream out;

    /** stderr print stream */
    static PrintStream err;

    /** this is the output stream for the logger result printer */
    static FileOutputStream output;

    /** print stream */
    static PrintStream ps;

    /**
     * Class representing the ResultPrinter type that this instance of the
     * ResultPrinterFactory will create.
     */
    private Class resultPrinterClass;

    /**
     * This method creates and returns a new instance of result printer factory.
     * The returned factory will be configured to create result printers of type
     * specified by the <code>utfx.result-printer.class</code> property. If
     * this method fails to instantiate a class of type specified in that
     * property then it will create and return a factory configured to use
     * JunitResultPrinter which is the default result printer.
     * 
     * @return instance of the result printer factory
     */
    public static ResultPrinterFactory newInstance() {

        ConfigurationManager cm = ConfigurationManager.getInstance();
        ResultPrinterFactory f = new ResultPrinterFactory();

        // The result printer class will be used by this result printer factory
        // to create result printers.
        f.resultPrinterClass = cm.getResultPrinterClass();

        return f;
    }

    /**
     * Get a result printer instance.
     * 
     * @return result printer or null if type is invalid
     */
    public ResultPrinter newResultPrinter() {
        ResultPrinter rp;
        Constructor c;
        ConfigurationManager cm = ConfigurationManager.getInstance();        
        try {
            c = resultPrinterClass.getConstructor(new Class[] {Class.forName("java.io.OutputStream")});
            rp = (ResultPrinter) c.newInstance(new Object[] {cm.getResultPrinterOutputStream()});
        } catch (Exception e) {
            e.printStackTrace();
            throw new AssertionError("Exception when creating new instance of "
                    + "ResultPrinter");
        }
        return rp;
    }
}