package utfx.framework.test;

import utfx.framework.ConfigurationManager;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * utfx.framework.ConfigurationManager test class.
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/test/ConfigurationManagerTest.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date: 2008-12-08 11:16:56 +0100 (Mon, 08 Dec 2008)
 *          $ $Name: $
 */
public class ConfigurationManagerTest extends TestCase {

	private static final String SOURCE_PARSER_KEY = "utfx.source-parser.class";
	private static final String TEMPLATE_ENGINE_KEY = "utfx.tdf.templateEngine.class";

	/**
	 * Constructs a test with a specified name.
	 * 
	 * @param name
	 *            the test name
	 */
	public ConfigurationManagerTest(String name) throws Exception {
		super(name);
	}

	/**
	 * Test singleton. Call getInstance() twice and make sure that both
	 * instances are the same; i.e. are the same singleton.
	 */
	public void testGetInstance() throws Exception {
		ConfigurationManager cm1, cm2;
		cm1 = ConfigurationManager.getInstance();
		cm2 = ConfigurationManager.getInstance();

		assertSame("getInstance() did not return a 'singleton'", cm1, cm2);
	}

	public void testSystemPropertyOverrideUtfxPropertyNotAvailable() throws Exception {
		assertNull(ConfigurationManager.getInstance().getOverrideProperty("notAvailable"));
	}

	public void testSystemPropertyOverrideUtfxProperty() throws Exception {
		assertEquals("utfx.framework.DefaultSourceParser", ConfigurationManager.getInstance().getOverrideProperty(SOURCE_PARSER_KEY));
	}

	public void testSystemPropertyOverrideSystemProperty() throws Exception {
		final String value = "isFun";
		final SystemPropertyRestorer sysProp = new SystemPropertyRestorer(SOURCE_PARSER_KEY, value);
		assertEquals(value, ConfigurationManager.getInstance().getOverrideProperty(SOURCE_PARSER_KEY));
		sysProp.restore();
	}

	public void testGetTemplateEngineNoneConfigured() throws Exception {
		assertNull(ConfigurationManager.getInstance().getTemplateEngine());
	}

	public void testGetTemplateEngineWronglyConfigured() throws Exception {
		final SystemPropertyRestorer sysProp = new SystemPropertyRestorer(TEMPLATE_ENGINE_KEY, "thisIsNoClassAvailableOnTheClassPath");
		try {
			ConfigurationManager.getInstance().getTemplateEngine();
			fail("a exception should have been thrown");
		} catch (RuntimeException e) {
			// fine. we expected an exception.
		}
		sysProp.restore();
	}

	public void testGetTemplateEngineCorrectlyConfigured() throws Exception {
		final SystemPropertyRestorer sysProp = new SystemPropertyRestorer(TEMPLATE_ENGINE_KEY, "utfx.templateEngine.SimpleTemplateEngine");
		assertNotNull(ConfigurationManager.getInstance().getTemplateEngine());
		sysProp.restore();
	}

	/**
	 * Gets a reference to this test suite.
	 * 
	 * @return this test suite.
	 */
	public static Test suite() {
		TestSuite suite = new TestSuite(ConfigurationManagerTest.class);
		return suite;
	}
}