package utfx.framework;

import java.io.File;
import java.io.FilenameFilter;

/**
 * Test Definition File implements java.io.FilenameFilter and provides UTF-X
 * with a default rule on how to find UTF-X test definition files in a given
 * directory. You may use your own UTF-X test definition filename filter by
 * providing a class that implements java.io.FilenameFilter.
 * 
 * <p>
 * Copyright &copy; 2006 - UTF-X Development Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/TestFileFilter.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 67 $ $Date: 2006-11-18 10:40:44 +1000 (Sat, 18 Nov 2006) $
 *          $Name: $
 */
public class TDFFilter implements FilenameFilter {

    /**
     * This method implements the functionality requierd by the FilenameFilter
     * interface. It is used for filtering UTF-X test definition files. In this
     * implementation any file that ends with '_test.xml' and does not start
     * with a '.' or a '#' is passed throught the filter (emacs backup files
     * start with '.' or '#' and we do not want to include them).
     * 
     * @param dir
     *            directory where the file was found.
     * @param name
     *            file name to test
     * 
     * @return true iff the name of the file matches the filter; false
     *         otherwise.
     */
    public boolean accept(File dir, String name) {
        if (name.endsWith("_test.xml") && !name.startsWith("#")
                && !name.startsWith(".")) {
            return true;
        }
        return false;
    }
}