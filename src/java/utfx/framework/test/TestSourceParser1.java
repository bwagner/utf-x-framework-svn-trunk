package utfx.framework.test;

import java.io.InputStream;

import javax.xml.transform.Source;

/**
 * Test source parser.
 * 
 * <p>
 * Copyright &copy; 2006 USQ and Jacek Radajewski
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/TestSourceParser1.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$Date: 2006/03/19 01:09:02 $ $ $Name:  $
 */
public class TestSourceParser1 {

    private String p1;

    private String p2;

    public TestSourceParser1(String p1, String p2) {
        this.p1 = p1;
        this.p2 = p2;
    }

    public Source getSource(InputStream inStream) {
        return null;
    }

    public String getP1() {
        return p1;
    }

    public String getP2() {
        return p2;
    }
}
