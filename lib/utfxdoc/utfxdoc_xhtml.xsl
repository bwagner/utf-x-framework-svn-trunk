<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_xhtml.xsl 66 2007-07-18 03:35:11Z jacekrad $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: UTF-X documentation xhtml stylesheet
	
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $HeadURL: https://utfx-doc.svn.sourceforge.net/svnroot/utfx-doc/utfx-doc-core/trunk/xsl/utfxdoc_xhtml.xsl $
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Copyright(C) 2006 - 2007 UTF-X DOC development team.
	
  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.
  
  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.
  http://www.gnu.org/licenses/lgpl.html
  
  XML syntax highlighting adapted from:
  XML to HTML Verbatim Formatter with Syntax Highlighting
  Version 1.1
  LGPL (c) Oliver Becker, 2002-08-22
  obecker@informatik.hu-berlin.de
  Contributors: Doug Dicks, added auto-indent (parameter indent-elements)
  for pretty-print
  	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet version="2.0" xmlns:u="http://utf-x.sourceforge.net/xsd/utfxdoc_1_0/utfxdoc.xsd"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8" indent="yes" method="xhtml"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- root template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <document> the root element -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:document">
    <html>
      <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
        <title>
          <xsl:value-of select="./u:title"/>
        </title>
        <link href="utfxdoc.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <div class="ud-title">
          <xsl:value-of select="u:title"/>
        </div>
        <div class="ud-subtitle">
          <xsl:value-of select="u:subtitle"/>
        </div>
        <xsl:apply-templates select="u:author"/>
        <xsl:apply-templates select="u:version"/>
        <xsl:apply-templates select="u:date"/>
        <xsl:apply-templates select="u:copyright"/>
        <xsl:call-template name="print-toc"/>
        <xsl:apply-templates select="u:sect1"/>
        <xsl:apply-templates select="u:glossary"/>
      </body>
    </html>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <author> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:author">
    <div class="ud-author">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <version> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:version">
    <div class="ud-version">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <date> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:date">
    <div class="ud-date">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <copyright> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:copyright">
    <div class="ud-copyright">
      <xsl:text>Copyright &#0169; </xsl:text>
      <xsl:value-of select="./@year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- namespace context -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:namespace-context">
    <h2>Namespace Context</h2>
    <table bgcolor="#DDDDCC" cellpadding="5mm">
      <tbody>
        <tr>
          <th>Prefix</th>
          <th>Namespace</th>
        </tr>
        <xsl:for-each select=".//u:namespace">
          <tr>
            <td>
              <xsl:attribute name="style">
                <xsl:choose>
                  <xsl:when test="./@prefix-color = ''">
                    <xsl:text>font-family: Courier;</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>font-family: Courier; font-weight: bold; color: </xsl:text>
                    <xsl:value-of select="./@prefix-color"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:value-of select="./u:prefix"/>
            </td>
            <td style="font-family: Courier">
              <xsl:value-of select="./u:uri"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect1> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect1">
    <!-- 
    <a>
      <xsl:attribute name="name">
        <xsl:value-of select="./@id"/>
      </xsl:attribute>
    </a>
    -->
    <a>
      <xsl:attribute name="name">
        <xsl:text>sect</xsl:text>
        <xsl:value-of select="@number"/>
      </xsl:attribute>
    </a>
    <h1>
      <xsl:value-of select="@number"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="./u:title"/>
    </h1>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect2> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect2">
    <a>
      <xsl:attribute name="name">
        <xsl:value-of select="./@id"/>
      </xsl:attribute>
    </a>
    <a>
      <xsl:attribute name="name">
        <xsl:text>sect</xsl:text>
        <xsl:value-of select="@number"/>
      </xsl:attribute>
    </a>
    <h2>
      <xsl:value-of select="@number"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="./u:title"/>
    </h2>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect3> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect3">
    <a>
      <xsl:attribute name="name">
        <xsl:value-of select="./@id"/>
      </xsl:attribute>
    </a>
    <a>
      <xsl:attribute name="name">
        <xsl:text>sect</xsl:text>
        <xsl:value-of select="@number"/>
      </xsl:attribute>
    </a>
    <h3>
      <xsl:value-of select="@number"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="./u:title"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <title> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:title"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <para> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <element> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:element">
    <span style="color: #781068; font-family: Courier; font-weight:bold;">&lt;<xsl:value-of select="."
    />&gt;</span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <note> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:note">
    <div class="ud-note">
      <span style="font-size:12pt; font-weight:bold;">NOTE</span>
      <div>
        <xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <ordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:ordered_list">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <unordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:unordered_list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <item> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <url> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:url">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <pre> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:pre">
    <div style="color:brown">
      <code>
        <pre>
          <xsl:apply-templates/>
        </pre>
      </code>
    </div>
  </xsl:template>


  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <code> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:code">
    <span style="font-family:Courier; color:#003399; font-size:10pt">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <xref> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xref">
    <xsl:variable name="idref">
      <xsl:value-of select="@idref"/>
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$idref"/>
      </xsl:attribute>
      <xsl:value-of select="(//*[@id=$idref])[1]/@name"/>
    </a>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <link> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:link">
    <a target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="@url"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <figure> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:example | u:figure">
    <xsl:if test="./@id != ''">
      <a>
        <xsl:attribute name="name">
          <xsl:value-of select="./@id"/>
        </xsl:attribute>
      </a>
    </xsl:if>
    <p>
      <xsl:apply-templates select="u:img | u:xml | u:svg"/>
      <div>
        <xsl:text>Figure </xsl:text>
        <xsl:value-of select="./@number"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="u:caption"/>
      </div>
    </p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <caption> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:caption">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <img> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:img">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:if test="@width != ''">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <svg> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:svg">
    <embed>
      <xsl:attribute name="src">
        <xsl:value-of select="@src"/>
      </xsl:attribute>
      <xsl:if test="@width != ''">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@height != ''">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
    </embed>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <class> - Java class name -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:class">
    <span style="font-family:Courier">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary">
    <h1>Glossary</h1>
    <table border="1">
      <tbody>
        <tr>
          <th>Term</th>
          <th>Definition</th>
        </tr>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary_entry>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary_entry">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <term>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:term">
    <th>
      <xsl:apply-templates/>
    </th>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <definition>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:definition">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <xml> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xml">
    <xsl:choose>
      <!-- parent is an example -->
      <!-- TODO test below fails if different prefix is used; use unqualified name -->
      <xsl:when test="local-name(parent::node()) = 'example'">
        <xsl:choose>
          <xsl:when test="parent::node()/@type = 'correct'">
            <div class="ud-correct-example-code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </div>
          </xsl:when>
          <xsl:when test="parent::node()/@type = 'incorrect'">
            <div class="ud-incorrect-example-code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div class="ud-code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </div>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- parent is a figure or a standalone u:xml fragment -->
      <xsl:otherwise>
        <div class="ud-code-block">
          <xsl:apply-templates mode="xmlverb" select="node()"/>
        </div>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text() template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- named template to print table of contents -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-toc">
    <h1>Table of Contents</h1>
    <div class="ud-toc">
      <table width="80%">
        <colgroup>
          <col align="left" width="2%"/>
          <col align="left" width="2%"/>
          <col align="left" width="96%"/>
        </colgroup>
        <tbody>

          <!-- section -->
          <xsl:for-each select="/u:document/u:sect1">
            <tr>
              <td colspan="3">
                <a>
                  <xsl:attribute name="href">
                    <xsl:text>#sect</xsl:text>
                    <xsl:value-of select="@number"/>
                  </xsl:attribute>
                  <xsl:value-of select="./@number"/>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:value-of select="./u:title"/>
                </a>
              </td>
            </tr>
            <!-- sub-section -->
            <xsl:for-each select="./u:sect2">
              <tr>
                <td>&#160;</td>
                <td colspan="2">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:text>#sect</xsl:text>
                      <xsl:value-of select="@number"/>
                    </xsl:attribute>
                    <xsl:value-of select="./@number"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="./u:title"/>
                  </a>
                </td>
              </tr>

              <!-- sub-sub-section -->
              <xsl:for-each select="./u:sect3">
                <tr>
                  <td>
                    <xsl:text>&#160;</xsl:text>
                  </td>
                  <td>
                    <xsl:text>&#160;</xsl:text>
                  </td>
                  <td>
                    <a>
                      <xsl:attribute name="href">
                        <xsl:text>#sect</xsl:text>
                        <xsl:value-of select="@number"/>
                      </xsl:attribute>
                      <xsl:value-of select="./@number"/>
                      <xsl:text>&#160;</xsl:text>
                      <xsl:value-of select="./u:title"/>
                    </a>
                  </td>
                </tr>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- highlight element -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="highlight" mode="xmlverb">
    <span class="ud-highlight">
      <xsl:apply-templates mode="xmlverb"/>
    </span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- element nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="*" mode="xmlverb">
    <xsl:param name="indent-elements" select="false()"/>
    <xsl:param name="indent" select="''"/>
    <xsl:param name="indent-increment" select="'&#xA0;&#xA0;&#xA0;'"/>
    <xsl:if test="$indent-elements">
      <br/>
      <xsl:value-of select="$indent"/>
    </xsl:if>
    <xsl:text>&lt;</xsl:text>
    <xsl:variable name="ns-prefix" select="substring-before(name(),':')"/>
    <xsl:if test="$ns-prefix != ''">
      <xsl:call-template name="print-prefix">
        <xsl:with-param name="prefix-name" select="$ns-prefix"/>
      </xsl:call-template>
      <xsl:text>:</xsl:text>
    </xsl:if>
    <span class="ud-xml-element-name">
      <xsl:value-of select="local-name()"/>
    </span>
    <xsl:variable name="pns" select="../namespace::*"/>
    <xsl:if test="$pns[name()=''] and not(namespace::*[name()=''])">
      <span class="ud-xml-ns-name">
        <xsl:text> xmlns</xsl:text>
      </span>
      <xsl:text>=&quot;&quot;</xsl:text>
    </xsl:if>
    <xsl:for-each select="namespace::*">
      <xsl:if test="not($pns[name()=name(current()) and 
        .=current()])">
        <xsl:call-template name="xmlverb-ns"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="@*">
      <xsl:call-template name="xmlverb-attrs"/>
    </xsl:for-each>
    <xsl:choose>
      <xsl:when test="node()">
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates mode="xmlverb">
          <xsl:with-param name="indent-elements" select="$indent-elements"/>
          <xsl:with-param name="indent" select="concat($indent, $indent-increment)"/>
          <xsl:with-param name="indent-increment" select="$indent-increment"/>
        </xsl:apply-templates>
        <xsl:if test="* and $indent-elements">
          <br/>
          <xsl:value-of select="$indent"/>
        </xsl:if>
        <xsl:text>&lt;/</xsl:text>
        <xsl:if test="$ns-prefix != ''">
          <xsl:call-template name="print-prefix">
            <xsl:with-param name="prefix-name" select="$ns-prefix"/>
          </xsl:call-template>
          <xsl:text>:</xsl:text>
        </xsl:if>
        <span class="ud-xml-element-name">
          <xsl:value-of select="local-name()"/>
        </span>
        <xsl:text>&gt;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> /&gt;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="not(parent::*)">
      <br/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- attribute nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="xmlverb-attrs">
    <xsl:text> </xsl:text>
    <span class="ud-xml-attr-name">
      <xsl:value-of select="name()"/>
    </span>
    <xsl:text>=&quot;</xsl:text>
    <span class="ud-xml-attr-content">
      <xsl:call-template name="html-replace-entities">
        <xsl:with-param name="text" select="normalize-space(.)"/>
        <xsl:with-param name="attrs" select="true()"/>
      </xsl:call-template>
    </span>
    <xsl:text>&quot;</xsl:text>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- namespace nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="xmlverb-ns">
    <xsl:if test="name()!='xml'">
      <span class="ud-xml-ns-name">
        <xsl:text> xmlns</xsl:text>
        <xsl:if test="name()!=''">
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:value-of select="name()"/>
      </span>
      <xsl:text>=&quot;</xsl:text>
      <span class="ud-xml-ns-uri">
        <xsl:value-of select="."/>
      </span>
      <xsl:text>&quot;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()" mode="xmlverb">
    <span class="ud-xml-text">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text">
          <xsl:call-template name="html-replace-entities">
            <xsl:with-param name="text" select="."/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- comments -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="comment()" mode="xmlverb">
    <xsl:text>&lt;!--</xsl:text>
    <span class="ud-xml-comment">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text" select="."/>
      </xsl:call-template>
    </span>
    <xsl:text>--&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <br/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- processing instructions -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="processing-instruction()" mode="xmlverb">
    <xsl:text>&lt;?</xsl:text>
    <span class="ud-xml-pi-name">
      <xsl:value-of select="name()"/>
    </span>
    <xsl:if test=".!=''">
      <xsl:text> </xsl:text>
      <span class="ud-xmlverb-pi-content">
        <xsl:value-of select="."/>
      </span>
    </xsl:if>
    <xsl:text>?&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <br/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- print prefix -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-prefix">
    <xsl:param name="prefix-name"/>
    <xsl:variable name="prefix-element" select="//u:prefix[text() = $prefix-name]"/>
    <span class="ud-xml-element-nsprefix">
      <xsl:attribute name="style">
        <xsl:choose>
          <xsl:when test="$prefix-element/../@prefix-color = ''">
            <xsl:value-of select="'color: black;'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>color: </xsl:text>
            <xsl:value-of select="$prefix-element/../@prefix-color"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="$prefix-name"/>
    </span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- generate entities by replacing &, ", < and > in $text -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="html-replace-entities">
    <xsl:param name="text"/>
    <xsl:param name="attrs"/>
    <xsl:variable name="tmp">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="from" select="'&gt;'"/>
        <xsl:with-param name="to" select="'&amp;gt;'"/>
        <xsl:with-param name="value">
          <xsl:call-template name="replace-substring">
            <xsl:with-param name="from" select="'&lt;'"/>
            <xsl:with-param name="to" select="'&amp;lt;'"/>
            <xsl:with-param name="value">
              <xsl:call-template name="replace-substring">
                <xsl:with-param name="from" select="'&amp;'"/>
                <xsl:with-param name="to" select="'&amp;amp;'"/>
                <xsl:with-param name="value" select="$text"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <!-- $text is an attribute value -->
      <xsl:when test="$attrs">
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="from" select="'&#xA;'"/>
          <xsl:with-param name="to" select="'&amp;#xA;'"/>
          <xsl:with-param name="value">
            <xsl:call-template name="replace-substring">
              <xsl:with-param name="from" select="'&quot;'"/>
              <xsl:with-param name="to" select="'&amp;quot;'"/>
              <xsl:with-param name="value" select="$tmp"/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$tmp"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- replace in $value substring $from with $to -->
  <xsl:template name="replace-substring">
    <xsl:param name="value"/>
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:choose>
      <xsl:when test="contains($value,$from)">
        <xsl:value-of select="substring-before($value,$from)"/>
        <xsl:value-of select="$to"/>
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="value" select="substring-after($value,$from)"/>
          <xsl:with-param name="from" select="$from"/>
          <xsl:with-param name="to" select="$to"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- preformatted output: space as &nbsp;, tab as 8 &nbsp;
    nl as <br> -->
  <xsl:template name="preformatted-output">
    <xsl:param name="text"/>
    <xsl:call-template name="output-nl">
      <xsl:with-param name="text">
        <xsl:call-template name="replace-substring">
          <xsl:with-param name="value" select="translate($text,' ','&#xA0;')"/>
          <xsl:with-param name="from" select="'&#9;'"/>
          <xsl:with-param name="to"
            select="'&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;'"
          />
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- output nl as <br> -->
  <xsl:template name="output-nl">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,'&#xA;')">
        <xsl:value-of select="substring-before($text,'&#xA;')"/>
        <br/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:call-template name="output-nl">
          <xsl:with-param name="text" select="substring-after($text,'&#xA;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
