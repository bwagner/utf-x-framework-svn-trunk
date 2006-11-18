package utfx.framework;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * This class uses reflection to load a Source Parser class.
 * <p>
 * Copyright &copy; 2004 - <a href="http://www.usq.edu.au"> University of
 * Southern Queensland. </a>
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
 * $Source: /cvs/utf-x/framework/src/java/utfx/framework/SourceParserFactory.java,v $
 * </code>
 * 
 * @author Jacek Radajewski
 * @version $Revision: 1.1 $ $Date: 2005/03/23 02:25:13 $ $Name:  $
 */
public class SourceParserFactory {

    private Object[] parameters;

    private Class[] parameterTypes;

    /** LOG4J logging facility */
    private Logger log;

    private String className;

    /** XPath factory */
    private XPathFactory xpf;

    /** XPath */
    private XPath xpath;

    /**
     * 
     */
    public SourceParserFactory() {
        log = Logger.getLogger("utfx.framework");
        xpf = XPathFactory.newInstance();
        xpath = xpf.newXPath();
        xpath.setNamespaceContext(new UTFXNamespaceContext());
    }

    /**
     * Load a source builder class.
     * 
     * @param node
     * @return
     * @throws NoSuchMethodException
     * @throws SecurityException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws InvocationTargetException
     */
    private Object load() throws ClassNotFoundException, SecurityException,
            NoSuchMethodException, InvocationTargetException,
            InstantiationException, IllegalAccessException,
            InvocationTargetException {

        Class clazz = null;
        Object sourceBuilder;
        Constructor constructor;

        clazz = Class.forName(className);
        clazz.getMethod("getSource", java.io.InputStream.class);
        constructor = clazz.getConstructor(parameterTypes);
        sourceBuilder = constructor.newInstance(parameters);

        return sourceBuilder;
    }

    public SourceParser getSourceParser(Element elem)
            throws ClassNotFoundException, NoSuchMethodException,
            NoSuchMethodException, IllegalAccessException,
            InvocationTargetException, InstantiationException,
            IllegalAccessException, XPathExpressionException {

        Object sourceBuilderImpl;
        SourceParser sourceBuilder;

        parse(elem);

        sourceBuilderImpl = load();
        if (sourceBuilderImpl instanceof SourceParser) {
            sourceBuilder = (SourceParser) sourceBuilderImpl;
        } else {
            sourceBuilder = new SourceParserWrapper(sourceBuilderImpl);
        }

        return sourceBuilder;
    }

    /**
     * @param elem
     * @throws ClassNotFoundException
     * @throws NoSuchMethodException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws InvocationTargetException
     */
    private void parse(Element elem) throws ClassNotFoundException,
            NoSuchMethodException, NoSuchMethodException,
            InvocationTargetException, InstantiationException,
            IllegalAccessException, InvocationTargetException,
            XPathExpressionException {

        int paramCount;
        Element paramElem;
        NodeList paramElems;
        String typeName, value;
        Class paramType;
        Object paramValue;
        Constructor constructor;
        Class[] constructorParamTypes = new Class[] { String.class };
        Object[] constructorParamValues = new Object[1];

        className = xpath.evaluate("utfx:class-name", elem);
        log.debug("className = " + className);
        paramElems = (NodeList) xpath.evaluate(".//utfx:param", elem,
                XPathConstants.NODESET);
        paramCount = paramElems.getLength();
        log.debug("found " + paramCount + " param elements");
        parameters = new Object[paramCount];
        parameterTypes = new Class[paramCount];

        // process constructor parameters
        for (int i = 0; i < paramCount; i++) {
            paramElem = (Element) paramElems.item(i);
            typeName = paramElem.getAttribute("type");
            value = xpath.evaluate(".", paramElem);

            paramType = Class.forName("java.lang." + typeName);
            constructor = paramType.getConstructor(constructorParamTypes);
            constructorParamValues[0] = value;
            paramValue = constructor.newInstance(constructorParamValues);
            parameters[i] = paramValue;
            parameterTypes[i] = paramType;
        }
    }
}
