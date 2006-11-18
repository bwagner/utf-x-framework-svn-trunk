package utfx.printers;

import static java.lang.System.out;

import static utfx.printers.AnsiString.Colour.BLUE;
import static utfx.printers.AnsiString.Colour.CYAN;
import static utfx.printers.AnsiString.Colour.GREEN;
import static utfx.printers.AnsiString.Colour.PURPLE;
import static utfx.printers.AnsiString.Colour.RED;
import static utfx.printers.AnsiString.Colour.YELLOW;


/**
 * This class represents an ANSI colour escaped string. An ANSI string will
 * produce colour output on terminals that support ANSI colour escaping. Linux
 * console and xterm are examples of such terminals.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/printers/AnsiString.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class AnsiString implements java.io.Serializable {

    /**
     * Comment for <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = 1L;

    public enum Colour {
        RED, GREEN, BLUE, PURPLE, CYAN, YELLOW

    }

    /** <font color="red">escape sequence for red </font> */
    private static final String RED_ESC = "\033[1;31m";

    /** <font color="green">escape sequence for green </font> */
    private static final String GREEN_ESC = "\033[1;32m";

    /** <font color="blue">escape sequence for blue </font> */
    private static final String BLUE_ESC = "\033[1;34m";

    /** <font color="purple">escape sequence for purple </font> */
    private static final String PURPLE_ESC = "\033[1;35m";

    /** <font color="cyan">escape sequence for cyan </font> */
    private static final String CYAN_ESC = "\033[1;36m";

    /** <font color="yellow">escape sequence for yellow </font> */
    private static final String YELLOW_ESC = "\033[1;33m";

    /** escape sequence to reset back to the default colour */
    private static final String RESET_ESC = "\033[0m";

    /** content of this ANSI string WITHOUT colour escape sequences */
    private String rawContent;

    /** this strings colour */
    private Colour colour;

    /**
     * if this is true then the toString() method will return ANSI escaped
     * string. If false than standard, not escaped, raw version of the String
     * will be used.
     */
    private static boolean ansiColour = true;

    /**
     * Construct a new colour ANSI String.
     * 
     * @param rawContent string to wrap in ANSI colour
     * @param colour colour ANSI escape sequence to wrap around the string
     */
    public AnsiString(String rawContent, Colour colour) {
        this.rawContent = rawContent;
        this.colour = colour;
    }

    /**
     * Construct a new colour ANSI String.
     * 
     * @param stringBuffer string to wrap in ANSI colour
     * @param colour colour ANSI escape sequence to wrap around the string
     */
    public AnsiString(StringBuffer stringBuffer, Colour colour) {
        this.rawContent = stringBuffer.toString();
        this.colour = colour;
    }

    /**
     * method to turn off ANSI escaping. ON by default.
     */
    public static void disableAnsiColour() {
        ansiColour = false;
    }

    /**
     * method to turn on ANSI escaping. ON by default.
     */
    public static void enableAnsiColour() {
        ansiColour = true;
    }

    /**
     * @return ANSI escaped string.
     */
    private String getAnsiString() {

        switch (colour) {

        case RED:
            return RED_ESC + rawContent + RESET_ESC;
        case GREEN:
            return GREEN_ESC + rawContent + RESET_ESC;
        case BLUE:
            return BLUE_ESC + rawContent + RESET_ESC;
        case PURPLE:
            return PURPLE_ESC + rawContent + RESET_ESC;
        case CYAN:
            return CYAN_ESC + rawContent + RESET_ESC;
        case YELLOW:
            return YELLOW_ESC + rawContent + RESET_ESC;
        default:
            return rawContent;
        }

    }

    /**
     * @return the content of this ansi string. The returned content will be
     *         ANSI colour escaped unless ansiEscape was disabled.
     */
    public String toString() {
        if (ansiColour) {
            return getAnsiString();
        }
        return rawContent;
    }

    public static void main(String s[]) {

        out.println("" + new AnsiString("red", Colour.RED));
        out.println("" + new AnsiString("green", Colour.GREEN));
        out.println("" + new AnsiString("blue", Colour.BLUE));
        out.println("" + new AnsiString("purple", Colour.PURPLE));
        out.println("" + new AnsiString("cyan", Colour.CYAN));
        out.println("" + new AnsiString("yellow", Colour.YELLOW));

    }

}