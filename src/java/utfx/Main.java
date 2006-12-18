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

    

    private static String testFile;

    private static String testDir;

    private static String xsltFile;

    public static final int SUCCESS_EXIT = 0;

    public static final int FAILURE_EXIT = 1;

    public static final int EXCEPTION_EXIT = 2;

    private static void printUsage() {
        out.println("java -jar utfx.jar -tdf test_definition_file.xml");
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
        char option;
        while (i < args.length && args[i].startsWith("-")) {

            arg = args[i++];

            if (arg.equals("-utfx.test.file")) {
                if (i < args.length) {
                    testFile = args[i++];
                } else {
                    System.err.println("-utfx.test.file requires a filename");
                }
            } else if (arg.equals("-utfx.test.dir")) {
                if (i < args.length) {
                    testDir = args[i++];
                } else {
                    System.err.println("-utfx.test.dir requires a directory");
                }
            } else if (arg.equals("-xslt")) {
                if (i < args.length) {
                    xsltFile = args[i++];
                } else {
                    System.err.println("-xslt requires a xslt filename");

                }
            }

            // check for execution modes.
            for (int j = 1; j < arg.length(); j++) {
                option = arg.charAt(j);
                switch (option) {
                case 't':

                    break;
                case 'r':
                    System.out.println("Run tests...");
                    System.setProperty("utfx.test.file", testFile);
                    System.setProperty("utfx.test.dir", testDir);
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
                    System.out.println("Generate tests...");
                    new TestGenerator(xsltFile);

                    break;

                default:
                    System.err.println(": illegal option " + option);
                    printUsage();
                    break;
                }
            }
        }
    }

}
