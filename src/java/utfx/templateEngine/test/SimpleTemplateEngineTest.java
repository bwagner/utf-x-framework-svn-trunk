package utfx.templateEngine.test;

import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import utfx.templateEngine.SimpleTemplateEngine;

/**
 * JUnit test case for SimpleTemplateEngine
 * 
 * <p>
 * Copyright &copy; 2008 UTF-X Development Team.
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
public class SimpleTemplateEngineTest extends TestCase {

	private SimpleTemplateEngine templateEngine;
	private Writer output;
	private Map<Object, Object> context;

	protected void setUp() throws Exception {
		super.setUp();
		templateEngine = new SimpleTemplateEngine();
		output = new StringWriter();
		context = new Properties();
	}

	public void testEvaluateWithEmptyTemplate() throws Exception {
		templateEngine.evaluate(new StringReader(""), output, context);
		assertEquals("", output.toString());
	}

	public void testEvaluateWithoutVariable() throws Exception {
		String testString = "A text without any variables";
		templateEngine.evaluate(new StringReader(testString), output, context);
		assertEquals(testString + "\n", output.toString());
	}

	public void testEvaluateWithVariableOnly1() throws Exception {
		final String variableValue = ":-)";
		context.put("attitude", variableValue);
		templateEngine.evaluate(new StringReader("${attitude}"), output, context);
		assertEquals(variableValue + "\n", output.toString());
	}

	public void testEvaluateWithVariableOnly2() throws Exception {
		final String variableValue = "don't worry be happy";
		context.put("bobby", variableValue);
		templateEngine.evaluate(new StringReader("${bobby}"), output, context);
		assertEquals(variableValue + "\n", output.toString());
	}

	public void testEvaluateWithTextAndVariable() throws Exception {
		context.put("app", "UTF-X");
		templateEngine.evaluate(new StringReader("I like ${app}!"), output, context);
		assertEquals("I like UTF-X!" + "\n", output.toString());
	}

	public void testEvaluateWithTextAndTwoVariables() throws Exception {
		context.put("food", "eggs");
		context.put("when", "morning");
		templateEngine.evaluate(new StringReader("I had ${food} in the ${when}."), output, context);
		assertEquals("I had eggs in the morning.\n", output.toString());
	}

	// new line is not allowed in variable name
	public void testEvaluateWithVariableContainingNewline() throws Exception {
		context.put("special\nvariable", "123");
		templateEngine.evaluate(new StringReader("${special\nvariable}456789"), output, context);
		assertEquals("${special\nvariable}456789\n", output.toString());
	}

	public void testEvaluateWithVariableMissingInContext() throws Exception {
		templateEngine.evaluate(new StringReader("${notInContext}"), output, context);
		assertEquals("${notInContext}\n", output.toString());
	}

	public void testEvaluateWithVariableReferenceNameDoesNotEnd() throws Exception {
		templateEngine.evaluate(new StringReader("${startButNoEnd"), output, context);
		assertEquals("${startButNoEnd\n", output.toString());
	}

	public void testEvaluateWithEmptyVariableReference() throws Exception {
		templateEngine.evaluate(new StringReader("${}"), output, context);
		assertEquals("${}\n", output.toString());
	}

	// Verify that by using PECS [1] we can have generic maps of different types
	// than Map<Object, Object> without type casting and compiler warning
	//
	// [1] Item 28: Bounded Wildcards for API Flexibility of Joshua Bloch's book Effective Java 2nd edition
	// - http://www.parleys.com/display/PARLEYS/Home#slide=5;title=Effective%20Java%20Reloaded;talk=18317360
	// - http://www.amazon.com/Effective-Java-2nd-Joshua-Bloch/dp/0321356683/ref=pd_bbs_sr_1?ie=UTF8&s=books&qid=1228482992&sr=8-1
	public void testWithDifferentContextType() throws Exception {
		Map<String, String> context = new HashMap<String, String>();
		templateEngine.evaluate(new StringReader("different context type\n"), output, context);
		assertEquals("different context type\n", output.toString());
	}
	
    /**
     * Creates a test suite for this class.
     * 
     * @return this test suite
     */
    public static Test suite() {
        TestSuite suite = new TestSuite(SimpleTemplateEngineTest.class);
        return suite;
    }

}
