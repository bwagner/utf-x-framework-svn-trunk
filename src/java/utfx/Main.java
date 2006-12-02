package utfx;

import static java.lang.System.out;

/**
 * TODO one line class description.???
 * TODO complete class documentation.
 * 
 * <p>
 * Copyright &copy; 2006 UTF-X Development Team.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/Attic/Main.java,v $
 * </code>
 * 
 * @author jacekrad
 * @version $Revision$ $Date$ $Name:  $
 */
public class Main {

    private static void printUsage() {
        out.println("java -jar utfx.jar -tdf test_definition_file.xml");
    }
    
    /**
     * @param args
     */
    public static void main(String[] args) {
        printUsage();

    }

}
