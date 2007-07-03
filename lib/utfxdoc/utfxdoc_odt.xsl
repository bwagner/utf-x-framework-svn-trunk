<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_xhtml.xsl 59 2007-05-08 03:50:19Z jacekrad $
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
  	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet version="2.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
  xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dom="http://www.w3.org/2001/xml-events"
  xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
  xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
  xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
  xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
  xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
  xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
  xmlns:ooo="http://openoffice.org/2004/office" xmlns:oooc="http://openoffice.org/2004/calc"
  xmlns:ooow="http://openoffice.org/2004/writer"
  xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
  xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
  xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
  xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
  xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
  xmlns:u="http://utf-x.sourceforge.net/xsd/utfxdoc_1_0/utfxdoc.xsd"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8" indent="no" method="xml"/>

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
    <office:document-content office:version="1.0">
      <xsl:apply-templates/>
      <office:scripts/>
      <office:font-face-decls>
        <style:font-face style:name="Tahoma1" svg:font-family="Tahoma"/>
        <style:font-face style:font-pitch="variable" style:name="Arial Unicode MS"
          svg:font-family="&apos;Arial Unicode MS&apos;"/>
        <style:font-face style:font-pitch="variable" style:name="Tahoma" svg:font-family="Tahoma"/>
        <style:font-face style:font-family-generic="roman" style:font-pitch="variable"
          style:name="Times New Roman" svg:font-family="&apos;Times New Roman&apos;"/>
        <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
          style:name="Arial" svg:font-family="Arial"/>
      </office:font-face-decls>
      <office:automatic-styles>
        <style:style style:family="paragraph" style:name="P1" style:parent-style-name="Standard">
          <style:text-properties fo:font-weight="bold" style:font-weight-asian="bold"
            style:font-weight-complex="bold"/>
        </style:style>
        <style:style style:family="paragraph" style:name="P2" style:parent-style-name="Standard">
          <style:text-properties fo:font-style="italic"/>
        </style:style>
      </office:automatic-styles>
      <office:body>
        <office:text>
          <office:forms form:apply-design-mode="false" form:automatic-focus="false"/>
          <text:sequence-decls>
            <text:sequence-decl text:display-outline-level="0" text:name="Illustration"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Table"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Text"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Drawing"/>
          </text:sequence-decls>
          <text:p text:style-name="Standard">First line of text</text:p>
          <text:p text:style-name="Standard"/>
          <text:p text:style-name="P1">second line of text</text:p>
          <text:p text:style-name="P2">more text</text:p>
        </office:text>
      </office:body>      
    </office:document-content>
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

  <!-- ############################################################### -->
  <!-- ############################################################### -->
  <!-- ############################################################### -->
  <!-- ############################################################### -->
  
  <xsl:template name="create-settings">
    <xsl:result-document href="settings.xml">
      <office:document-settings office:version="1.0"
        xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
        xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
        xmlns:ooo="http://openoffice.org/2004/office" xmlns:xlink="http://www.w3.org/1999/xlink">
        <office:settings>
          <config:config-item-set config:name="ooo:view-settings">
            <config:config-item config:name="ViewAreaTop" config:type="int">0</config:config-item>
            <config:config-item config:name="ViewAreaLeft" config:type="int">0</config:config-item>
            <config:config-item config:name="ViewAreaWidth" config:type="int">32625</config:config-item>
            <config:config-item config:name="ViewAreaHeight" config:type="int">20692</config:config-item>
            <config:config-item config:name="ShowRedlineChanges" config:type="boolean">true</config:config-item>
            <config:config-item config:name="InBrowseMode" config:type="boolean">false</config:config-item>
            <config:config-item-map-indexed config:name="Views">
              <config:config-item-map-entry>
                <config:config-item config:name="ViewId" config:type="string">view2</config:config-item>
                <config:config-item config:name="ViewLeft" config:type="int">3002</config:config-item>
                <config:config-item config:name="ViewTop" config:type="int">3976</config:config-item>
                <config:config-item config:name="VisibleLeft" config:type="int">0</config:config-item>
                <config:config-item config:name="VisibleTop" config:type="int">0</config:config-item>
                <config:config-item config:name="VisibleRight" config:type="int">32623</config:config-item>
                <config:config-item config:name="VisibleBottom" config:type="int">20690</config:config-item>
                <config:config-item config:name="ZoomType" config:type="short">0</config:config-item>
                <config:config-item config:name="ZoomFactor" config:type="short">100</config:config-item>
                <config:config-item config:name="IsSelectedFrame" config:type="boolean"
                  >false</config:config-item>
              </config:config-item-map-entry>
            </config:config-item-map-indexed>
          </config:config-item-set>
          <config:config-item-set config:name="ooo:configuration-settings">
            <config:config-item config:name="AddParaTableSpacing" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrintReversed" config:type="boolean">false</config:config-item>
            <config:config-item config:name="OutlineLevelYieldsNumbering" config:type="boolean">false</config:config-item>
            <config:config-item config:name="LinkUpdateMode" config:type="short">1</config:config-item>
            <config:config-item config:name="PrintEmptyPages" config:type="boolean">true</config:config-item>
            <config:config-item config:name="IgnoreFirstLineIndentInNumbering" config:type="boolean">false</config:config-item>
            <config:config-item config:name="CharacterCompressionType" config:type="short">0</config:config-item>
            <config:config-item config:name="PrintSingleJobs" config:type="boolean">false</config:config-item>
            <config:config-item config:name="UpdateFromTemplate" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintPaperFromSetup" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AddFrameOffsets" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintLeftPages" config:type="boolean">true</config:config-item>
            <config:config-item config:name="RedlineProtectionKey" config:type="base64Binary"/>
            <config:config-item config:name="PrintTables" config:type="boolean">true</config:config-item>
            <config:config-item config:name="ChartAutoUpdate" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrintControls" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrinterSetup" config:type="base64Binary"/>
            <config:config-item config:name="PrintAnnotationMode" config:type="short">0</config:config-item>
            <config:config-item config:name="LoadReadonly" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AddParaSpacingToTableCells" config:type="boolean">true</config:config-item>
            <config:config-item config:name="AddExternalLeading" config:type="boolean">true</config:config-item>
            <config:config-item config:name="ApplyUserData" config:type="boolean">true</config:config-item>
            <config:config-item config:name="FieldAutoUpdate" config:type="boolean">true</config:config-item>
            <config:config-item config:name="SaveVersionOnClose" config:type="boolean">false</config:config-item>
            <config:config-item config:name="SaveGlobalDocumentLinks" config:type="boolean">false</config:config-item>
            <config:config-item config:name="IsKernAsianPunctuation" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AlignTabStopPosition" config:type="boolean">true</config:config-item>
            <config:config-item config:name="CurrentDatabaseDataSource" config:type="string"/>
            <config:config-item config:name="PrinterName" config:type="string"/>
            <config:config-item config:name="PrintFaxName" config:type="string"/>
            <config:config-item config:name="ConsiderTextWrapOnObjPos" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintRightPages" config:type="boolean">true</config:config-item>
            <config:config-item config:name="IsLabelDocument" config:type="boolean">false</config:config-item>
            <config:config-item config:name="UseFormerLineSpacing" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AddParaTableSpacingAtStart" config:type="boolean">true</config:config-item>
            <config:config-item config:name="UseFormerTextWrapping" config:type="boolean">false</config:config-item>
            <config:config-item config:name="DoNotResetParaAttrsForNumFont" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintProspect" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintGraphics" config:type="boolean">true</config:config-item>
            <config:config-item config:name="AllowPrintJobCancel" config:type="boolean">true</config:config-item>
            <config:config-item config:name="CurrentDatabaseCommandType" config:type="int">0</config:config-item>
            <config:config-item config:name="DoNotJustifyLinesWithManualBreak" config:type="boolean">false</config:config-item>
            <config:config-item config:name="UseFormerObjectPositioning" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrinterIndependentLayout" config:type="string"
              >high-resolution</config:config-item>
            <config:config-item config:name="UseOldNumbering" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintPageBackground" config:type="boolean">true</config:config-item>
            <config:config-item config:name="CurrentDatabaseCommand" config:type="string"/>
            <config:config-item config:name="PrintDrawings" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrintBlackFonts" config:type="boolean"
              >false</config:config-item>
          </config:config-item-set>
        </office:settings>
      </office:document-settings>      
    </xsl:result-document>
  </xsl:template>
  
  <!-- ############################################################### -->
  <!-- ############################################################### -->

  <xsl:template name="create-meta">
    <xsl:result-document href="meta.xml">
      <office:document-meta office:version="1.0">
        <office:meta/> 
      </office:document-meta>
    </xsl:result-document>
  </xsl:template>

  <!-- ############################################################### -->
  <!-- ############################################################### -->

  <xsl:template name="create-styles">
    <xsl:result-document href="styles.xml">
      <office:document-styles office:version="1.0">
        <office:font-face-decls>
          <style:font-face style:name="Tahoma1" svg:font-family="Tahoma"/>
          <style:font-face style:font-pitch="variable" style:name="Arial Unicode MS"
            svg:font-family="&apos;Arial Unicode MS&apos;"/>
          <style:font-face style:font-pitch="variable" style:name="Tahoma" svg:font-family="Tahoma"/>
          <style:font-face style:font-family-generic="roman" style:font-pitch="variable"
            style:name="Times New Roman" svg:font-family="&apos;Times New Roman&apos;"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Arial" svg:font-family="Arial"/>
        </office:font-face-decls>
        <office:styles>
          <style:default-style style:family="graphic">
            <style:graphic-properties draw:end-line-spacing-horizontal="0.283cm"
              draw:end-line-spacing-vertical="0.283cm" draw:shadow-offset-x="0.3cm"
              draw:shadow-offset-y="0.3cm" draw:start-line-spacing-horizontal="0.283cm"
              draw:start-line-spacing-vertical="0.283cm" style:flow-with-text="false"/>
            <style:paragraph-properties style:font-independent-line-spacing="false"
              style:line-break="strict" style:text-autospace="ideograph-alpha"
              style:writing-mode="lr-tb">
              <style:tab-stops/>
            </style:paragraph-properties>
            <style:text-properties fo:country="AU" fo:font-size="12pt" fo:language="en"
              style:country-asian="none" style:country-complex="none" style:font-size-asian="12pt"
              style:font-size-complex="12pt" style:language-asian="none"
              style:language-complex="none" style:use-window-font-color="true"/>
          </style:default-style>
          <style:default-style style:family="paragraph">
            <style:paragraph-properties fo:hyphenation-ladder-count="no-limit"
              style:line-break="strict" style:punctuation-wrap="hanging"
              style:tab-stop-distance="1.251cm" style:text-autospace="ideograph-alpha"
              style:writing-mode="page"/>
            <style:text-properties fo:country="AU" fo:font-size="12pt" fo:hyphenate="false"
              fo:hyphenation-push-char-count="2" fo:hyphenation-remain-char-count="2"
              fo:language="en" style:country-asian="none" style:country-complex="none"
              style:font-name="Times New Roman" style:font-name-asian="Arial Unicode MS"
              style:font-name-complex="Tahoma" style:font-size-asian="12pt"
              style:font-size-complex="12pt" style:language-asian="none"
              style:language-complex="none" style:use-window-font-color="true"/>
          </style:default-style>
          <style:default-style style:family="table">
            <style:table-properties table:border-model="collapsing"/>
          </style:default-style>
          <style:default-style style:family="table-row">
            <style:table-row-properties fo:keep-together="auto"/>
          </style:default-style>
          <style:style style:class="text" style:family="paragraph" style:name="Standard"/>
          <style:style style:class="text" style:display-name="Text body" style:family="paragraph"
            style:name="Text_20_body" style:parent-style-name="Standard">
            <style:paragraph-properties fo:margin-bottom="0.212cm" fo:margin-top="0cm"/>
          </style:style>
          <style:style style:class="text" style:family="paragraph" style:name="Heading"
            style:next-style-name="Text_20_body" style:parent-style-name="Standard">
            <style:paragraph-properties fo:keep-with-next="always" fo:margin-bottom="0.212cm"
              fo:margin-top="0.423cm"/>
            <style:text-properties fo:font-size="14pt" style:font-name="Arial"
              style:font-name-asian="Arial Unicode MS" style:font-name-complex="Tahoma"
              style:font-size-asian="14pt" style:font-size-complex="14pt"/>
          </style:style>
          <style:style style:class="list" style:family="paragraph" style:name="List"
            style:parent-style-name="Text_20_body">
            <style:text-properties style:font-name-complex="Tahoma1"/>
          </style:style>
          <style:style style:class="extra" style:family="paragraph" style:name="Caption"
            style:parent-style-name="Standard">
            <style:paragraph-properties fo:margin-bottom="0.212cm" fo:margin-top="0.212cm"
              text:line-number="0" text:number-lines="false"/>
            <style:text-properties fo:font-size="12pt" fo:font-style="italic"
              style:font-name-complex="Tahoma1" style:font-size-asian="12pt"
              style:font-size-complex="12pt" style:font-style-asian="italic"
              style:font-style-complex="italic"/>
          </style:style>
          <style:style style:class="index" style:family="paragraph" style:name="Index"
            style:parent-style-name="Standard">
            <style:paragraph-properties text:line-number="0" text:number-lines="false"/>
            <style:text-properties style:font-name-complex="Tahoma1"/>
          </style:style>
          <text:outline-style>
            <text:outline-level-style style:num-format="" text:level="1">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="2">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="3">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="4">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="5">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="6">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="7">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="8">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="9">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
            <text:outline-level-style style:num-format="" text:level="10">
              <style:list-level-properties text:min-label-distance="0.381cm"/>
            </text:outline-level-style>
          </text:outline-style>
          <text:notes-configuration style:num-format="1" text:footnotes-position="page"
            text:note-class="footnote" text:start-numbering-at="document" text:start-value="0"/>
          <text:notes-configuration style:num-format="i" text:note-class="endnote"
            text:start-value="0"/>
          <text:linenumbering-configuration style:num-format="1" text:increment="5"
            text:number-lines="false" text:number-position="left" text:offset="0.499cm"/>
        </office:styles>
        <office:automatic-styles>
          <style:page-layout style:name="pm1">
            <style:page-layout-properties fo:margin-bottom="2cm" fo:margin-left="2cm"
              fo:margin-right="2cm" fo:margin-top="2cm" fo:page-height="29.699cm"
              fo:page-width="20.999cm" style:footnote-max-height="0cm" style:num-format="1"
              style:print-orientation="portrait" style:writing-mode="lr-tb">
              <style:footnote-sep style:adjustment="left" style:color="#000000"
                style:distance-after-sep="0.101cm" style:distance-before-sep="0.101cm"
                style:rel-width="25%" style:width="0.018cm"/>
            </style:page-layout-properties>
            <style:header-style/>
            <style:footer-style/>
          </style:page-layout>
        </office:automatic-styles>
        <office:master-styles>
          <style:master-page style:name="Standard" style:page-layout-name="pm1"/>
        </office:master-styles>
      </office:document-styles>
    </xsl:result-document>
  </xsl:template>

</xsl:stylesheet>
