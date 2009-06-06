package utfx.templateEngine;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Simple template engine which replaces variable references of the ${variableName} syntax
 * <p>
 * Note:<ul>
 * <li>The class is not thread safe.
 * <li>The class is not intended for sub classing therefore it is declared final.
 * </ul><p>
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
public final class SimpleTemplateEngine implements TemplateEngine {

	private Writer output;
	private Map<? extends Object, ? extends Object> context;
	private Pattern pattern = Pattern.compile("\\$\\{[^}]*\\}");
	
	/**
	 * Replace variable references of the ${variableName} syntax in template with values in context
	 * <p>
	 * Note:<ul>
	 * <li>All characters but }, \r and \n are allowed in the variable name
	 * <li>There is no special escaping available for $, { and }, i.e. if you have
	 * ${variableName} in your template it will always be replaced by the
	 * context if variableName is available there
	 * <li>A BufferedReader is used for reading. As an implication line separators
	 * are normalized to \n and the last line always end with a \n
	 * 
	 * @throws IOException
	 * @see utfx.templateEngine.TemplateEngine#evaluate(java.io.Reader,
	 *      java.io.Writer, java.util.Map)
	 */
	public void evaluate(Reader template, Writer output, Map<? extends Object, ? extends Object> context) throws IOException {
		this.output = output;
		this.context = context;
		evaluate(template);
	}

	private void evaluate(Reader template) throws IOException {
		BufferedReader bufferedReader = new BufferedReader(template);
		String line;
		while ((line = bufferedReader.readLine()) != null) {
			evaluate(line);
			output.append("\n");
		}
	}

	private void evaluate(String line) throws IOException {
		Matcher matcher = pattern.matcher(line);
		int index = 0;
		while (matcher.find()) {
			addPrecedingPlainText(line, index, matcher);
			addVariable(line, index, matcher);
			index = matcher.end();
		}
		addTail(line, index);
	}

	private void addPrecedingPlainText(String line, int index, Matcher matcher) throws IOException {
		if (index != matcher.start()) {
			output.append(line, index, matcher.start());
		}
	}

	private void addVariable(String line, int index, Matcher matcher) throws IOException {
		String variableReference = line.substring(matcher.start(), matcher.end());
		Object value = context.get(extractVariableName(variableReference));
		if (value == null) {
			output.append(variableReference);
		} else {
			output.append(value.toString());
		}
	}

	private void addTail(String line, int index) throws IOException {
		output.append(line, index, line.length());
	}

	private String extractVariableName(String variable) {
		return variable.substring(2, variable.length() - 1);
	}

}
