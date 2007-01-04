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
 * @author eraonel
 * @version $Revision$ $Date$ $Name: $
 */
public class Main {

    // TODO: I am working on this file.

    
    private  ResultPrinterFactory rpf;
    private static String file;

    private static String dir;

    public static final int SUCCESS_EXIT = 0;

    public static final int FAILURE_EXIT = 1;

    public static final int EXCEPTION_EXIT = 2;
    
    public static final int GENERATE_TESTS = 1;
    public static final int EXECUTE_TESTS = 2;
    public static final int RUN_TESTS = 3;
    public static int PROCESS_MODE= 0;

    private static void printUsage() {
        out.println("Usage: Main [-verbose] [-help]-trg [-file afile| -dir directory]");
        out.println("Example 1: Main -r -dir C:\\mytests\\ ");
        out.println("Example 2: Main -g -file C:\\");
        System.exit(1);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        /** result printer factory */
       
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
                System.out.println("Number of arguments: "+args.length);
                verbose = true;
            }else if (arg.equals("-help")) {
                printUsage();
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
                        if (verbose) System.out.println("Option -t");
                        break;
                    case 'r':
                        if (verbose) System.out.println("Option -r");
                        //checkFileOrDir
                        if (file != null)System.setProperty("utfx.test.file", file);
                        if (dir != null)System.setProperty("utfx.test.dir", dir);
                        PROCESS_MODE=RUN_TESTS;
                        break;
                    case 'g':
                        if (verbose) System.out.println("Option g");
                        PROCESS_MODE=GENERATE_TESTS;
                        break;    
                    default:
                        System.err.println("Main: illegal option " + flag);
                        break;
                    }
                }
               
            }
            
        }//finnish handling args.
        
        Main main = new Main();
        main.processMode(PROCESS_MODE);
    }
    
    private void processMode(int mode){
        
        switch (mode) {
        case RUN_TESTS:
            runTests();
            break;
        case GENERATE_TESTS:
            genTests();
            break;

        default:
            break;
        }
        
        
    }
    
    private void runTests(){
       
        rpf = ResultPrinterFactory.newInstance();
        TestRunner tr = new TestRunner();
        String testName = "utfx.framework.XSLTRegressionTest";
        Test suite = tr
                .getTest(testName);
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
    }
    
    private void genTests(){
        new TestGenerator(file);
    }
    
    

}
