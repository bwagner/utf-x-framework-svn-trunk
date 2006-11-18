package utfx.framework;

import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.xml.transform.Source;

/**
 * This special source builder is used for wrapping source builders that do not
 * implement the SourceParser interface. This funtionality is required to
 * support source builders compiled under j2se 1.4
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/SourceParserWrapper.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision$ $Date$ $Name:  $
 */
public class SourceParserWrapper implements SourceParser {

	/**
	 * The source builder we are wrapping.
	 */
	private Object sourceBuilder;

	/**
	 * Create a new instance of SourceParserWrapper.
	 * 
	 * @param sourceBuilder
	 *            the source builder we are warpping.
	 */
	public SourceParserWrapper(Object sourceBuilder) {
		this.sourceBuilder = sourceBuilder;
	}

	/**
	 * 
	 * @see utfx.framework.SourceParser#getSource(java.io.InputStream)
	 */
	public Source getSource(InputStream inStream) throws Exception {
		Source source = null;
		Method getSource;
		Object[] params = new Object[] { inStream };

		// invoke specifically the method with InputStream parameter
		// as using inStream.getClass() causes the jvm to look for
		// that exact method signature
		getSource = sourceBuilder.getClass().getMethod("getSource",
				InputStream.class);

		// catch the invocation exception and throw the cause since
		// that's what we are interested in
		try {
			source = (Source) getSource.invoke(sourceBuilder, params);
		} catch (InvocationTargetException ite) {
			throw new Exception(ite.getCause());
		}

		return source;
	}

	/**
	 * @return the source builder this class is wrapping.
	 */
	public Object getSourceBuilder() {
		return sourceBuilder;
	}

}
