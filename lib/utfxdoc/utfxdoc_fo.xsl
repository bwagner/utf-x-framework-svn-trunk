<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_fo.xsl 59 2007-05-08 03:50:19Z jacekrad $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
   Purpose: UTF-X doc XSL:FO generating stylesheet
	
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $HeadURL: https://utfx-doc.svn.sourceforge.net/svnroot/utfx-doc/utfx-doc-core/trunk/xsl/utfxdoc_fo.xsl $
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
<xsl:stylesheet version="2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:u="http://utf-x.sourceforge.net/xsd/utfxdoc_1_0/utfxdoc.xsd"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8" indent="no" method="xml"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- attribute sets -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:attribute-set name="block">
    <xsl:attribute name="space-before">2mm</xsl:attribute>
    <xsl:attribute name="space-after">2mm</xsl:attribute>
    <xsl:attribute name="margin-left">2mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="code-block">
    <xsl:attribute name="padding">5mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="background-color">#FFFFF8</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#f5a90b</xsl:attribute>
    <xsl:attribute name="border-width">px1</xsl:attribute>
    <xsl:attribute name="width">80%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="note">
    <xsl:attribute name="padding">2mm</xsl:attribute>
    <xsl:attribute name="keep-together">always</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="background-color">#BBFFEE</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#448877</xsl:attribute>
    <xsl:attribute name="border-width">2px</xsl:attribute>
    <xsl:attribute name="width">80%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="correct-example-code-block">
    <xsl:attribute name="padding">5mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="background-color">#F8FFF8</xsl:attribute>
    <xsl:attribute name="border-color">green</xsl:attribute>
    <xsl:attribute name="border-width">2px</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="incorrect-example-code-block">
    <xsl:attribute name="padding">5mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="background-color">#FFF8F8</xsl:attribute>
    <xsl:attribute name="border-color">red</xsl:attribute>
    <xsl:attribute name="border-width">2px</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="author"/>

  <xsl:attribute-set name="version"/>

  <xsl:attribute-set name="date"/>

  <xsl:attribute-set name="copyright"/>

  <xsl:attribute-set name="h1">
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="space-before">5mm</xsl:attribute>
    <xsl:attribute name="space-after">2mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="color">#f5a90b</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h2">
    <xsl:attribute name="font-size">16pt</xsl:attribute>
    <xsl:attribute name="space-before">5mm</xsl:attribute>
    <xsl:attribute name="space-after">2mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="color">#f5a90b</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h3">
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="space-before">5mm</xsl:attribute>
    <xsl:attribute name="space-after">2mm</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="color">#f5a90b</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-default">
    <xsl:attribute name="color">#334455</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-element-nsprefix">
    <xsl:attribute name="color">#666600</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-element-name">
    <xsl:attribute name="color">#990000</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-ns-name">
    <xsl:attribute name="color">#666600</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-attr-name">
    <xsl:attribute name="color">#660000</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-attr-content">
    <xsl:attribute name="color">#000099</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-ns-uri">
    <xsl:attribute name="color">#330099</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-text">
    <xsl:attribute name="color">#000000</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-comment">
    <xsl:attribute name="color">#006600</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-pi-name">
    <xsl:attribute name="color">#006600</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-xml-pi-content">
    <xsl:attribute name="color">#006666</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ud-highlight">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- highlight xml -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->  
  <xsl:template match="highlight" mode="xmlverb">
    <fo:inline xsl:use-attribute-sets="ud-highlight">
      <xsl:apply-templates mode="xmlverb"/>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- element nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->  
  <xsl:template match="*" mode="xmlverb">
    <xsl:param name="indent-elements" select="false()"/>
    <xsl:param name="indent" select="''"/>
    <xsl:param name="indent-increment" select="'&#xA0;&#xA0;&#xA0;'"/>
    <xsl:if test="$indent-elements">
      <fo:block/>
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
    <fo:inline xsl:use-attribute-sets="ud-xml-element-name">
      <xsl:value-of select="local-name()"/>
    </fo:inline>
    <xsl:variable name="pns" select="../namespace::*"/>
    <xsl:if test="$pns[name()=''] and not(namespace::*[name()=''])">
      <fo:inline xsl:use-attribute-sets="ud-xml-ns-name">
        <xsl:text> xmlns</xsl:text>
      </fo:inline>
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
          <fo:block/>
          <xsl:value-of select="$indent"/>
        </xsl:if>
        <xsl:text>&lt;/</xsl:text>
        <xsl:if test="$ns-prefix != ''">
          <xsl:call-template name="print-prefix">
            <xsl:with-param name="prefix-name" select="$ns-prefix"/>
          </xsl:call-template>
          <xsl:text>:</xsl:text>
        </xsl:if>
        <fo:inline xsl:use-attribute-sets="ud-xml-element-name">
          <xsl:value-of select="local-name()"/>
        </fo:inline>
        <xsl:text>&gt;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> /&gt;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="not(parent::*)">
      <fo:block/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- attribute nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->  
  <xsl:template name="xmlverb-attrs">
    <xsl:text> </xsl:text>
    <fo:inline xsl:use-attribute-sets="ud-xml-attr-name">
      <xsl:value-of select="name()"/>
    </fo:inline>
    <xsl:text>=&quot;</xsl:text>
    <fo:inline xsl:use-attribute-sets="ud-xml-attr-content">
      <xsl:call-template name="html-replace-entities">
        <xsl:with-param name="text" select="normalize-space(.)"/>
        <xsl:with-param name="attrs" select="true()"/>
      </xsl:call-template>
    </fo:inline>
    <xsl:text>&quot;</xsl:text>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- namespace nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->  
  <xsl:template name="xmlverb-ns">
    <xsl:if test="name()!='xml'">
      <fo:inline xsl:use-attribute-sets="ud-xml-ns-name">
        <xsl:text> xmlns</xsl:text>
        <xsl:if test="name()!=''">
          <xsl:text>:</xsl:text>
        </xsl:if>
        <xsl:value-of select="name()"/>
      </fo:inline>
      <xsl:text>=&quot;</xsl:text>
      <fo:inline xsl:use-attribute-sets="ud-xml-ns-uri">
        <xsl:value-of select="."/>
      </fo:inline>
      <xsl:text>&quot;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text nodes -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()" mode="xmlverb">
    <fo:inline xsl:use-attribute-sets="ud-xml-text">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text">
          <xsl:call-template name="html-replace-entities">
            <xsl:with-param name="text" select="."/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- comments -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->  
  <xsl:template match="comment()" mode="xmlverb">
    <xsl:text>&lt;!--</xsl:text>
    <fo:inline xsl:use-attribute-sets="ud-xml-comment">
      <xsl:call-template name="preformatted-output">
        <xsl:with-param name="text" select="."/>
      </xsl:call-template>
    </fo:inline>
    <xsl:text>--&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <fo:block/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- processing instructions -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="processing-instruction()" mode="xmlverb">
    <xsl:text>&lt;?</xsl:text>
    <fo:inline xsl:use-attribute-sets="ud-xml-pi-name">
      <xsl:value-of select="name()"/>
    </fo:inline>
    <xsl:if test=".!=''">
      <xsl:text> </xsl:text>
      <fo:inline xsl:use-attribute-sets="ud-xml-pi-content">
        <xsl:value-of select="."/>
      </fo:inline>
    </xsl:if>
    <xsl:text>?&gt;</xsl:text>
    <xsl:if test="not(parent::*)">
      <fo:block/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- print prefix -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-prefix">
    <xsl:param name="prefix-name"/>
    <xsl:variable name="prefix-element" select="//u:prefix[text() = $prefix-name]"/>
    <fo:inline xsl:use-attribute-sets="ud-xml-element-nsprefix">
      <xsl:attribute name="color">
        <xsl:choose>
          <xsl:when test="$prefix-element/../@prefix-color = ''">
            <xsl:value-of select="black"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$prefix-element/../@prefix-color"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:value-of select="$prefix-name"/>
    </fo:inline>
  </xsl:template>

  <!-- generate entities by replacing &, ", < and > in $text -->
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
                             nl as <fo:block/> -->
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

  <!-- output nl as <fo:block/> -->
  <xsl:template name="output-nl">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,'&#xA;')">
        <xsl:value-of select="substring-before($text,'&#xA;')"/>
        <fo:block/>
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
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master margin-bottom="20mm" margin-left="15mm" margin-right="35mm"
          margin-top="80mm" master-name="title-page-master" page-height="297mm" page-width="210mm">
          <fo:region-body margin-bottom="10mm" margin-top="15mm" region-name="xsl-region-body"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start extent="150mm" region-name="xsl-region-start"/>
        </fo:simple-page-master>
        <fo:simple-page-master margin-bottom="20mm" margin-left="15mm" margin-right="35mm"
          margin-top="20mm" master-name="toc-page-master" page-height="297mm" page-width="210mm">
          <fo:region-body margin-bottom="10mm" margin-top="15mm" region-name="xsl-region-body"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start extent="150mm" region-name="xsl-region-start"/>
        </fo:simple-page-master>
        <fo:simple-page-master margin-bottom="20mm" margin-left="15mm" margin-right="35mm"
          margin-top="20mm" master-name="content-page-master" page-height="297mm" page-width="210mm">
          <fo:region-body margin-bottom="10mm" margin-top="15mm" region-name="xsl-region-body"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start extent="150mm" region-name="xsl-region-start"/>
        </fo:simple-page-master>
        <!--~~~~~~~~~~~~~~~~~~~~~~-->
        <!-- define page sequence -->
        <!--~~~~~~~~~~~~~~~~~~~~~~-->
        <fo:page-sequence-master master-name="title-sequence-master">
          <fo:repeatable-page-master-reference master-reference="title-page-master"/>
        </fo:page-sequence-master>
        <fo:page-sequence-master master-name="toc-sequence-master">
          <fo:repeatable-page-master-reference master-reference="toc-page-master"/>
        </fo:page-sequence-master>
        <fo:page-sequence-master master-name="content-sequence-master">
          <fo:repeatable-page-master-reference master-reference="content-page-master"/>
        </fo:page-sequence-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="title-sequence-master">
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center">
            <!--
          <fo:external-graphic src="http://utf-x.sourceforge.net/images/utf-x.gif" width="250px"/>
          -->
          </fo:block>
          <fo:block color="brown" font-size="38pt" font-weight="bold" text-align="right">
            <xsl:value-of select="u:title"/>
          </fo:block>
          <fo:block color="brown" font-size="28pt" font-weight="bold" text-align="right">
            <xsl:value-of select="u:subtitle"/>
          </fo:block>
          <fo:block space-before="60mm"/>
          <xsl:apply-templates select="u:author"/>
          <fo:block font-size="12pt" text-align="left">
            <xsl:apply-templates select="u:version"/>
          </fo:block>
          <fo:block font-size="12pt" text-align="left">
            <xsl:apply-templates select="./u:date"/>
          </fo:block>
          <fo:block font-size="12pt" text-align="left">
            <xsl:apply-templates select="./u:copyright"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="toc-sequence-master">
        <fo:flow flow-name="xsl-region-body">
          <fo:block>
            <xsl:call-template name="print-toc"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="content-page-master">
        <!-- render the header, page number and stylesheet name -->
        <fo:static-content flow-name="xsl-region-start">
          <fo:block background-color="white" color="black" font-family="Helvetica" font-size="8.5pt"
            text-align="left">
            <fo:inline font-weight="bold">
              <xsl:text>Page </xsl:text>
              <fo:page-number/>
            </fo:inline>
            <fo:inline>
              <xsl:text> - </xsl:text>
              <xsl:value-of select="u:title"/>
            </fo:inline>
            <fo:inline color="grey" font-style="italic" text-align="center">&#160; XML document
              rendered using UTF-X Doc <fo:inline color="blue">
                <fo:basic-link external-destination="http://utf-x.sourceforge.net"
                  >http://utf-x.sourceforge.net</fo:basic-link>
              </fo:inline></fo:inline>
          </fo:block>
        </fo:static-content>
        <!-- end of header -->
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates select="u:sect1"/>
          <xsl:apply-templates select="u:glossary"/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <author> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:author">
    <fo:block xsl:use-attribute-sets="author">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <version> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:version">
    <fo:block xsl:use-attribute-sets="version">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <date> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:date">
    <fo:block xsl:use-attribute-sets="date">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <copyright> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:copyright">
    <fo:block xsl:use-attribute-sets="copyright">
      <xsl:text>Copyright &#0169; </xsl:text>
      <xsl:value-of select="./@year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text templates -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect1> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect1">
    <fo:block xsl:use-attribute-sets="h1">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <fo:inline>
        <xsl:attribute name="id">
          <xsl:text>sect</xsl:text>
          <xsl:value-of select="@number"/>
        </xsl:attribute>
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </fo:inline>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect2> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect2">
    <fo:block xsl:use-attribute-sets="h2">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <fo:inline>
        <xsl:attribute name="id">
          <xsl:text>sect</xsl:text>
          <xsl:value-of select="@number"/>
        </xsl:attribute>
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </fo:inline>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect3> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect3">
    <fo:block xsl:use-attribute-sets="h3">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <fo:inline>
        <xsl:attribute name="id">
          <xsl:text>sect</xsl:text>
          <xsl:value-of select="@number"/>
        </xsl:attribute>
        <xsl:value-of select="@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./u:title"/>
      </fo:inline>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <para> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:para">
    <fo:block font-family="Helvetica" font-size="12pt" text-align="left"
      xsl:use-attribute-sets="block">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <note> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:note">
    <fo:block xsl:use-attribute-sets="note">
      <fo:inline font-weight="bold">NOTE</fo:inline>
      <fo:block font-family="Helvetica" font-size="10pt" text-align="left"
        xsl:use-attribute-sets="block">
        <xsl:apply-templates/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <ordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:ordered_list">
    <fo:list-block xsl:use-attribute-sets="block">
      <xsl:for-each select="u:item">
        <fo:list-item space-after="2mm" space-before="2mm">
          <fo:list-item-label>
            <fo:block>
              <xsl:value-of select="position()"/>
              <xsl:text>.&#160;</xsl:text>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body>
            <fo:block margin-left="10mm">
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <unordered_list> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:unordered_list">
    <fo:block xsl:use-attribute-sets="block">
      <fo:list-block>
        <xsl:apply-templates/>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <item> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:item">
    <fo:list-item space-after="2mm" space-before="2mm">
      <fo:list-item-label>
        <fo:block>&#x2022;</fo:block>
      </fo:list-item-label>
      <fo:list-item-body>
        <fo:block margin-left="5mm">
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <url> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:url">
    <fo:inline color="blue">
      <xsl:value-of select="."/>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <pre> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:pre">
    <fo:block color="brown" font-family="Courier" font-size="8pt" linefeed-treatment="preserve"
      white-space-collapse="false" white-space-treatment="preserve" xsl:use-attribute-sets="block">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <code> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:code">
    <fo:inline color="#003399" font-family="Courier" font-size="10pt">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <xref> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xref">
    <xsl:variable name="idref">
      <xsl:value-of select="@idref"/>
    </xsl:variable>
    <fo:inline color="blue">
      <fo:basic-link>
        <xsl:attribute name="internal-destination">
          <xsl:value-of select="@idref"/>
        </xsl:attribute>
        <xsl:value-of select="(//*[@id=$idref])[1]/@name"/>
      </fo:basic-link>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <link> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:link">
    <fo:inline color="blue">
      <fo:basic-link>
        <xsl:attribute name="external-destination">
          <xsl:value-of select="@url"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </fo:basic-link>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- figure/example template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:figure | u:example">
    <fo:block xsl:use-attribute-sets="block">
      <xsl:if test="./@id != ''">
        <xsl:attribute name="id">
          <xsl:value-of select="./@id"/>
        </xsl:attribute>
      </xsl:if>
      <fo:block>
        <xsl:apply-templates select="u:img | u:xml | u:svg"/>
      </fo:block>
      <fo:block font-size="8pt" padding-left="2mm" padding-top="1mm" text-align="left">
        <xsl:text>Figure </xsl:text>
        <xsl:value-of select="./@number"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates select="u:caption"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <caption> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:caption">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <img> - Image -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:img">
    <fo:inline>
      <fo:external-graphic>
        <xsl:attribute name="src">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </fo:external-graphic>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- SVG -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:svg">
    <fo:inline>
      <fo:external-graphic>
        <xsl:attribute name="src">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </fo:external-graphic>
    </fo:inline>
  </xsl:template>


  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <class> - Java class name -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:class">
    <fo:inline font-family="Courier">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary">
    <fo:block xsl:use-attribute-sets="h1">Glossary</fo:block>
    <fo:list-block>
      <xsl:apply-templates/>
    </fo:list-block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <glossary_entry>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:glossary_entry">
    <fo:list-item space-after="2mm" space-before="2mm">
      <fo:list-item-label>
        <fo:block>&#x2022;</fo:block>
      </fo:list-item-label>
      <fo:list-item-body>
        <fo:block margin-left="5mm">
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="./u:term"/>
          </fo:inline>
          <fo:inline margin-left="7mm">
            <xsl:text> - </xsl:text>
            <xsl:apply-templates select="./u:definition"/>
          </fo:inline>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <term>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:term">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <definition>  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:definition">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- XML element  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:xml">
    <xsl:choose>
      <!-- parent is an example -->
      <xsl:when test="local-name(parent::node()) = 'example'">
        <xsl:choose>
          <xsl:when test="parent::node()/@type = 'correct'">
            <fo:block xsl:use-attribute-sets="correct-example-code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </fo:block>
          </xsl:when>
          <xsl:when test="parent::node()/@type = 'incorrect'">
            <fo:block xsl:use-attribute-sets="incorrect-example-code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </fo:block>
          </xsl:when>
          <xsl:otherwise>
            <fo:block xsl:use-attribute-sets="code-block">
              <xsl:apply-templates mode="xmlverb" select="node()"/>
            </fo:block>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <!-- parent is a figure or standalone u:xml fragment -->
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="code-block">
          <xsl:apply-templates mode="xmlverb" select="node()"/>
        </fo:block>
      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Print Table of Contents  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-toc">
    <fo:block xsl:use-attribute-sets="h1">
      <xsl:text>Table of Contents</xsl:text>
    </fo:block>
    <fo:block>
      <xsl:for-each select="/u:document/u:sect1">
        <fo:block font-size="14pt" margin-left="5mm" space-before="3pt">
          <fo:inline color="blue">
            <fo:basic-link>
              <xsl:attribute name="internal-destination">
                <xsl:text>sect</xsl:text>
                <xsl:value-of select="@number"/>
              </xsl:attribute>
              <xsl:value-of select="@number"/>
              <xsl:text>&#160;</xsl:text>
              <xsl:value-of select="u:title"/>
            </fo:basic-link>
          </fo:inline>
        </fo:block>
        <xsl:for-each select="./u:sect2">
          <fo:block font-size="12pt" margin-left="15mm" space-before="2pt">
            <fo:inline color="blue">
              <fo:basic-link>
                <xsl:attribute name="internal-destination">
                  <xsl:text>sect</xsl:text>
                  <xsl:value-of select="@number"/>
                </xsl:attribute>
                <xsl:value-of select="@number"/>
                <xsl:text>&#160;</xsl:text>
                <xsl:value-of select="u:title"/>
              </fo:basic-link>
            </fo:inline>
          </fo:block>
          <xsl:for-each select="./u:sect3">
            <fo:block font-size="10pt" margin-left="25mm" space-before="1pt">
              <fo:inline color="blue">
                <fo:basic-link>
                  <xsl:attribute name="internal-destination">
                    <xsl:text>sect</xsl:text>
                    <xsl:value-of select="@number"/>
                  </xsl:attribute>
                  <xsl:value-of select="@number"/>
                  <xsl:text>&#160;</xsl:text>
                  <xsl:value-of select="u:title"/>
                </fo:basic-link>
              </fo:inline>
            </fo:block>
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>
