package utfx.util.test;

import java.io.ByteArrayInputStream;

import javax.xml.transform.Source;

import utfx.framework.DefaultSourceParser;
import utfx.util.SourceSerializer;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * JUnit tests for SourceSerializer
 * @see utfx.util.SourceSerializer
 * 
 * <p>
 * Copyright &copy; 2007 UTF-X Development Team.
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
 * $Source: $
 * </code>
 * 
 * @author Alex Daniel
 * @version $Revision: $ $Date: $ $Name: $
 */
public class SourceSerializerTest extends TestCase {

    /**
     * @param arg0
     */
    public SourceSerializerTest(String arg0) {
        super(arg0);
    }

    /**
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        super.setUp();
    }

    /**
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }
    
    public final void testSerialize() throws Exception {
        String sourceString = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><utf-x>Junit Test</utf-x>";
        ByteArrayInputStream sourceStream = new ByteArrayInputStream(sourceString.getBytes());
        DefaultSourceParser defaultSourceParser = new DefaultSourceParser();
        Source source = defaultSourceParser.getSource(sourceStream);
        
        SourceSerializer serializer = new SourceSerializer();
        assertEquals(sourceString, serializer.serialize(source));
    }
    
    /**
     * Creates a test suite for this class.
     * 
     * @return this test suite
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(SourceSerializerTest.class);
        return suite;
    }
    
}
