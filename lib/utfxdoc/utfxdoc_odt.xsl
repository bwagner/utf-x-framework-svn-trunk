<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_odt.xsl 85 2007-09-19 21:17:19Z jacekrad $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: UTF-X documentation stylesheet for generating Open Document Format
          documents.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $HeadURL: https://utfx-doc.svn.sourceforge.net/svnroot/utfx-doc/utfx-doc-core/trunk/xsl/utfxdoc_odt.xsl $
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

  <xsl:param name="output-dir" select="'../odt-output'"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- root template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="/">
    <xsl:call-template name="create-manifest.xml"/>
    <xsl:call-template name="create-meta.xml"/>
    <xsl:call-template name="create-settings.xml"/>
    <xsl:call-template name="create-styles.xml"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <document> the root element -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:document">
    <xsl:variable name="filename" select="concat($output-dir, '/content.xml')"/>
    <xsl:result-document encoding="utf-8" href="{$filename}" indent="yes" method="xml">
      <office:document-content office:version="1.0"
        xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
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
        xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xlink="http://www.w3.org/1999/xlink"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <office:scripts/>
        <office:font-face-decls>
          <style:font-face style:font-charset="x-symbol" style:font-pitch="variable"
            style:name="Wingdings" svg:font-family="Wingdings"/>
          <style:font-face style:font-charset="x-symbol" style:font-family-generic="roman"
            style:font-pitch="variable" style:name="Symbol" svg:font-family="Symbol"/>
          <style:font-face style:font-family-generic="modern" style:name="Courier New"
            svg:font-family="&apos;Courier New&apos;"/>
          <style:font-face style:font-family-generic="modern" style:font-pitch="fixed"
            style:name="Courier New1" svg:font-family="&apos;Courier New&apos;"/>
          <style:font-face style:font-pitch="variable" style:name="Arial Unicode MS"
            svg:font-family="&apos;Arial Unicode MS&apos;"/>
          <style:font-face style:font-pitch="variable" style:name="Tahoma1" svg:font-family="Tahoma"/>
          <style:font-face style:font-family-generic="roman" style:font-pitch="variable"
            style:name="Times New Roman" svg:font-family="&apos;Times New Roman&apos;"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Arial" svg:font-family="Arial"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Arial Narrow" svg:font-family="&apos;Arial Narrow&apos;"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Arial Unicode MS1" svg:font-family="&apos;Arial Unicode MS&apos;"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Franklin Gothic Book"
            svg:font-family="&apos;Franklin Gothic Book&apos;"/>
          <style:font-face style:font-family-generic="swiss" style:font-pitch="variable"
            style:name="Tahoma" svg:font-family="Tahoma"/>
        </office:font-face-decls>
        <office:body>
          <office:text>
            <!--
            <text:sequence-decls>
              <text:sequence-decl text:display-outline-level="0" text:name="Illustration"/>
              <text:sequence-decl text:display-outline-level="0" text:name="Table"/>
              <text:sequence-decl text:display-outline-level="0" text:name="Text"/>
              <text:sequence-decl text:display-outline-level="0" text:name="Drawing"/>
              <text:sequence-decl text:display-outline-level="0" text:name="Figure"/>
            </text:sequence-decls>
            -->
            <xsl:apply-templates select="u:sect1"/>
            <xsl:apply-templates select="u:glossary"/>
          </office:text>
        </office:body>
      </office:document-content>
    </xsl:result-document>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <author> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:author">
    <text:p text:style-name="ud-author">
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <version> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:version">
    <text:p text:style-name="ud-version">
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <date> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:date">
    <text:p text:style-name="ud-date">
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <copyright> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:copyright">
    <text:p text:style-name="ud-copyright">
      <xsl:text>Copyright &#0169; </xsl:text>
      <xsl:value-of select="./@year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- namespace context -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:namespace-context">
    <!--
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
    -->
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
    <!-- 
    <a>
      <xsl:attribute name="name">
        <xsl:text>sect</xsl:text>
        <xsl:value-of select="@number"/>
      </xsl:attribute>
    </a>
    -->
    <text:section text:style-name="ud-sect1">
      <xsl:attribute name="text:name" select="./u:title"/>
      <text:h text:outline-level="1">
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </text:h>
      <xsl:apply-templates/>
    </text:section>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect2> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect2">
    <!--
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
    -->
    <text:section text:style-name="ud-sect2">
      <text:h text:outline-level="2">
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </text:h>
      <xsl:apply-templates/>
    </text:section>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect3> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect3">
    <!-- 
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
    -->
    <text:section text:style-name="ud-sect3">
      <text:h text:outline-level="3">
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </text:h>
      <xsl:apply-templates/>
    </text:section>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <title> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:title"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <para> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:para">
    <text:p text:style-name="ud-para">
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <note> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:note">
    <text:p text:style-name="ud-note">
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <ordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:ordered_list">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <unordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:unordered_list">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <item> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:item">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <url> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:url">
    <text:p>
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </text:p>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <pre> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:pre">
    <text:p>
      <xsl:apply-templates/>
    </text:p>
  </xsl:template>


  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <code> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:code">
    <text:span text:style-name="ud-code">
      <xsl:apply-templates/>
    </text:span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <xref> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xref">
    <!--
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
    -->
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <link> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:link">
    <!--
    <a target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="@url"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
    -->
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <figure> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:example | u:figure">
    <!--
    <xsl:if test="./@id != ''">
      <a>
        <xsl:attribute name="name">
          <xsl:value-of select="./@id"/>
        </xsl:attribute>
      </a>
    </xsl:if>
    -->
    <text:p>
      <xsl:apply-templates select="u:img | u:xml | u:svg"/>
      <text:p>
        <xsl:text>Figure </xsl:text>
        <xsl:value-of select="./@number"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="u:caption"/>
      </text:p>
    </text:p>

  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <caption> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:caption">
    <text:span>
      <xsl:apply-templates/>
    </text:span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <img> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:img">
    <!--
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
    -->
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <svg> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:svg">
    <!--
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
    -->
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <class> - Java class name -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:class">
    <text:span text:style-name="ud-class">
      <xsl:apply-templates/>
    </text:span>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary">
    <text:section text:style-name="ud-sect1">
      <text:h text:outline-level="1">Glossary</text:h>
      <table:table table:name="Glossary Table" table:style-name="ud-glossary-table">
        <table:table-columns>
          <table:table-column table:style-name="ud-glossary-table-col1"/>
          <table:table-column table:style-name="ud-glossary-table-col2"/>
        </table:table-columns>
        <table:table-rows>
          <table:table-row table:style-name="ud-glossary-table-row">
            <table:table-cell office:value-type="string">
              <text:p>Term</text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string">
              <text:p>Definition</text:p>
            </table:table-cell>
          </table:table-row>
          <xsl:apply-templates/>
        </table:table-rows>
      </table:table>

      <text:section text:style-name="ud-sect1">
        <text:h text:outline-level="1">Other Section Past Glossary</text:h>
      </text:section>

    </text:section>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary_entry>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary_entry">
    <table:table-row table:style-name="ud-glossary-table-row">
      <xsl:apply-templates/>
    </table:table-row>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <term>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:term">
    <table:table-cell office:value-type="string">
      <text:p>
        <xsl:apply-templates/>
      </text:p>
    </table:table-cell>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <definition>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:definition">
    <table:table-cell office:value-type="string">
      <text:p>
        <xsl:apply-templates/>
      </text:p>
    </table:table-cell>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <xml> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xml">
    <!--
    <xsl:choose>
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

      <xsl:otherwise>
        <div class="ud-code-block">
          <xsl:apply-templates mode="xmlverb" select="node()"/>
        </div>
      </xsl:otherwise>

    </xsl:choose>
    -->
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
    <text:span class="ud-highlight">
      <xsl:apply-templates mode="xmlverb"/>
    </text:span>
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
    <text:span class="ud-xml-text">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text">
          <xsl:call-template name="html-replace-entities">
            <xsl:with-param name="text" select="."/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </text:span>
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

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Create META-INF/manifest.xml -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="create-manifest.xml">
    <xsl:variable name="filename" select="concat($output-dir, '/META-INF/manifest.xml')"/>
    <xsl:result-document encoding="utf-8" href="{$filename}" indent="yes" method="xml">
      <manifest:manifest xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0">
        <manifest:file-entry manifest:full-path="content.xml" manifest:media-type="text/xml"/>
        <manifest:file-entry manifest:full-path="/"
          manifest:media-type="application/vnd.oasis.opendocument.text"/>
        <manifest:file-entry manifest:full-path="content.xml" manifest:media-type="text/xml"/>
        <manifest:file-entry manifest:full-path="styles.xml" manifest:media-type="text/xml"/>
        <manifest:file-entry manifest:full-path="meta.xml" manifest:media-type="text/xml"/>
        <manifest:file-entry manifest:full-path="settings.xml" manifest:media-type="text/xml"/>
      </manifest:manifest>
    </xsl:result-document>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Create meta.xml -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="create-meta.xml">
    <xsl:variable name="filename" select="concat($output-dir, '/meta.xml')"/>
    <xsl:result-document encoding="utf-8" href="{$filename}" indent="yes" method="xml">
      <office:document-meta office:version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
        xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
        xmlns:ooo="http://openoffice.org/2004/office" xmlns:xlink="http://www.w3.org/1999/xlink">
        <office:meta/>
      </office:document-meta>
    </xsl:result-document>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- settings.xml -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="create-settings.xml">
    <xsl:variable name="filename" select="concat($output-dir, '/settings.xml')"/>
    <xsl:result-document encoding="utf-8" href="{$filename}" indent="yes" method="xml">
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
                <config:config-item config:name="ViewLeft" config:type="int">19980</config:config-item>
                <config:config-item config:name="ViewTop" config:type="int">6084</config:config-item>
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
            <config:config-item config:name="AddParaTableSpacing" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintReversed" config:type="boolean">false</config:config-item>
            <config:config-item config:name="OutlineLevelYieldsNumbering" config:type="boolean"
              >false</config:config-item>
            <config:config-item config:name="LinkUpdateMode" config:type="short">1</config:config-item>
            <config:config-item-map-indexed config:name="ForbiddenCharacters">
              <config:config-item-map-entry>
                <config:config-item config:name="Language" config:type="string">ja</config:config-item>
                <config:config-item config:name="Country" config:type="string">JP</config:config-item>
                <config:config-item config:name="Variant" config:type="string"/>
                <config:config-item config:name="BeginLine" config:type="string"
                  >!%),.:;?]}¢°’”‰′″℃、。々〉》」』】〕゛゜ゝゞ・ヽヾ！％），．：；？］｝｡｣､･ﾞﾟ￠</config:config-item>
                <config:config-item config:name="EndLine" config:type="string"
                  >$([\{£¥‘“〈《「『【〔＄（［｛｢￡￥</config:config-item>
              </config:config-item-map-entry>
            </config:config-item-map-indexed>
            <config:config-item config:name="PrintEmptyPages" config:type="boolean">true</config:config-item>
            <config:config-item config:name="IgnoreFirstLineIndentInNumbering" config:type="boolean"
              >false</config:config-item>
            <config:config-item config:name="CharacterCompressionType" config:type="short">0</config:config-item>
            <config:config-item config:name="PrintSingleJobs" config:type="boolean">false</config:config-item>
            <config:config-item config:name="UpdateFromTemplate" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrintPaperFromSetup" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AddFrameOffsets" config:type="boolean">true</config:config-item>
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
            <config:config-item config:name="IsKernAsianPunctuation" config:type="boolean">true</config:config-item>
            <config:config-item config:name="AlignTabStopPosition" config:type="boolean">true</config:config-item>
            <config:config-item config:name="CurrentDatabaseDataSource" config:type="string"/>
            <config:config-item config:name="PrinterName" config:type="string"/>
            <config:config-item config:name="PrintFaxName" config:type="string"/>
            <config:config-item config:name="ConsiderTextWrapOnObjPos" config:type="boolean">true</config:config-item>
            <config:config-item config:name="PrintRightPages" config:type="boolean">true</config:config-item>
            <config:config-item config:name="IsLabelDocument" config:type="boolean">false</config:config-item>
            <config:config-item config:name="UseFormerLineSpacing" config:type="boolean">false</config:config-item>
            <config:config-item config:name="AddParaTableSpacingAtStart" config:type="boolean">true</config:config-item>
            <config:config-item config:name="UseFormerTextWrapping" config:type="boolean">false</config:config-item>
            <config:config-item config:name="DoNotResetParaAttrsForNumFont" config:type="boolean"
              >false</config:config-item>
            <config:config-item config:name="PrintProspect" config:type="boolean">false</config:config-item>
            <config:config-item config:name="PrintGraphics" config:type="boolean">true</config:config-item>
            <config:config-item config:name="AllowPrintJobCancel" config:type="boolean">true</config:config-item>
            <config:config-item config:name="CurrentDatabaseCommandType" config:type="int">0</config:config-item>
            <config:config-item config:name="DoNotJustifyLinesWithManualBreak" config:type="boolean"
              >false</config:config-item>
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

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Create styles.xml -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="create-styles.xml">
    <xsl:variable name="filename" select="concat($output-dir, '/styles.xml')"/>
    <xsl:variable name="styles.xml" select="document('odt_styles.xml')"/>
    <xsl:result-document encoding="utf-8" href="{$filename}" indent="yes" method="xml">
      <xsl:copy-of select="$styles.xml"/>
    </xsl:result-document>
  </xsl:template>

</xsl:stylesheet>
