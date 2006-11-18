package utfx.framework.test;

import java.io.InputStream;

import javax.xml.transform.Source;

import utfx.framework.SourceParser;

/**
 * Test Source Parser.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/TestSourceParser2.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.2 $Date: 2006/03/19 01:09:02 $ $ $Name:  $
 */
public class TestSourceParser2 implements SourceParser {

    private String p1;

    private Integer p2;

    private String p3;

    public TestSourceParser2(String p1, Integer p2, String p3) {
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
    }

    /*
     * (non-Javadoc)
     * 
     * @see utfx.framework.SourceParser#getSource(java.io.InputStream)
     */
    public Source getSource(InputStream is) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    public String getP1() {
        return p1;
    }

    public Integer getP2() {
        return p2;
    }

    public String getP3() {
        return p3;
    }
}
