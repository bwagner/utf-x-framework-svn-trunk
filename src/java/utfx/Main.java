package utfx;

import static java.lang.System.out;
import junit.framework.Test;
import junit.framework.TestResult;
import utfx.framework.XSLTRegressionTest;
import utfx.printers.ResultPrinterFactory;
import utfx.runner.TestRunner;
import utfx.testgen.TestGenerator;

/**
 * TODO one line class description.??? TODO complete class documentation.
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
 * @version $Revision$ $Date$ $Name: $
 */
public class Main {

    // TODO: I am working on this file.

    

    private static String file;

    private static String dir;

    public static final int SUCCESS_EXIT = 0;

    public static final int FAILURE_EXIT = 1;

    public static final int EXCEPTION_EXIT = 2;

    private static void printUsage() {
        out.println("Usage: Main [-verbose] [-xn] [-output afile] filename");
        System.exit(1);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        /** result printer factory */
        ResultPrinterFactory rpf;
        String arg;
        int i = 0;
        int j;
        char flag;
        boolean verbose = false;
        while (i < args.length && args[i].startsWith("-")) {

            arg = args[i++];
            
            // use this type of check for "wordy" arguments
            if (arg.equals("-debug")) {
                System.out.println("verbose mode on");
                verbose = true;
            }
            
            

            // use this type of check for arguments that require arguments
            else if(arg.equals("-file")) {
                if (i < args.length)
                    file = args[i++];
                else
                    System.err.println("-file requires a filename");
                if (verbose)
                    System.out.println("file = " + file);
            }else if(arg.equals("-dir")){
                if (i < args.length)
                    dir = args[i++];
                else
                    System.err.println("-dir requires a directory name");
                if (verbose)
                    System.out.println("directory = " + dir);
            }

    // use this type of check for a series of flag arguments
            else {
                for (j = 1; j < arg.length(); j++) {
                    flag = arg.charAt(j);
                    switch (flag) {
                    case 't':
                        if (verbose) System.out.println("Option t");
                        break;
                    case 'r':
                        if (verbose) System.out.println("Option r");
                        //checkFileOrDir
                        if (file != null)System.setProperty("utfx.test.file", file);
                        if (dir != null)System.setProperty("utfx.test.dir", dir);
                        
                        rpf = ResultPrinterFactory.newInstance();
                        TestRunner tr = new TestRunner();
                        Test suite = tr
                                .getTest("utfx.framework.XSLTRegressionTest");
                        try {
                            TestResult r = tr.doRun(suite, rpf);

                            if (!r.wasSuccessful()) {
                                System.exit(FAILURE_EXIT);
                            }
                            System.exit(SUCCESS_EXIT);
                        } catch (Exception e) {
                            System.err.println(e.getMessage());
                            System.exit(EXCEPTION_EXIT);
                        }
                        System.out.println("Done running tests!");

                        break;
                    case 'g':
                        if (verbose) System.out.println("Option g");
                        System.out.println("Generate tests...");
                        new TestGenerator(file);
                        break;    
                    default:
                        System.err.println("Main: illegal option " + flag);
                        break;
                    }
                }
            }


          

            
        }
    }

}
