package utfx.printers;

import junit.framework.AssertionFailedError;
import junit.framework.Test;
import junit.framework.TestListener;

import org.apache.log4j.Logger;

/**
 * This class is an implementation of junit TestListerner. This class uses the
 * log4j logging facility to log run test progress including failures and
 * errors.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/ResultLogger.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2005/03/09 03:53:16 $ $Name:  $
 */
public class ResultLogger implements TestListener {

    Logger log;

    public ResultLogger() {
        log = Logger.getLogger("utfx.test_results");
        log.info("logger created");
    }

    /*
     * (non-Javadoc)
     * 
     * @see junit.framework.TestListener#addError(junit.framework.Test,
     *      java.lang.Throwable)
     */
    public void addError(Test test, Throwable t) {
        log.error(test + " ERROR", t);
    }

    /*
     * (non-Javadoc)
     * 
     * @see junit.framework.TestListener#addFailure(junit.framework.Test,
     *      junit.framework.AssertionFailedError)
     */
    public void addFailure(Test test, AssertionFailedError t) {
        log.error(test + " FAILED", t);

    }

    /*
     * (non-Javadoc)
     * 
     * @see junit.framework.TestListener#endTest(junit.framework.Test)
     */
    public void endTest(Test test) {
        log.info(test + " completed");

    }

    /*
     * (non-Javadoc)
     * 
     * @see junit.framework.TestListener#startTest(junit.framework.Test)
     */
    public void startTest(Test test) {
        log.info(test + " started");

    }

}
