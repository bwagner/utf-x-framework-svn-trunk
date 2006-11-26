<?xml version="1.0" encoding="UTF-8"?>
<!--
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_fo.xsl 90 2006-11-25 09:01:16Z jacekrad $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: UTF-X doc XSL:FO generating stylesheet
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright(C) 2005-2006 UTF-X Developers.
	
 You may redistribute and/or modify this file under the terms of the
 GNU General Public License v2.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:u="http://utf-x.sourceforge.net/xsd/utfxdoc_1_0/utfxdoc.xsd">
  <xsl:import href="xmlverbatim_fo.xsl"/>

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
    <xsl:attribute name="background-color">#FFFFCC</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#f5a90b</xsl:attribute>
    <xsl:attribute name="border-width">1</xsl:attribute>
    <xsl:attribute name="width">90%</xsl:attribute>
  </xsl:attribute-set>

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
        <fo:simple-page-master master-name="title-page-master" page-height="297mm" page-width="210mm"
          margin-top="80mm" margin-bottom="20mm" margin-left="15mm" margin-right="35mm">
          <fo:region-body region-name="xsl-region-body" margin-top="15mm" margin-bottom="10mm"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start region-name="xsl-region-start" extent="150mm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="toc-page-master" page-height="297mm" page-width="210mm"
          margin-top="20mm" margin-bottom="20mm" margin-left="15mm" margin-right="35mm">
          <fo:region-body region-name="xsl-region-body" margin-top="15mm" margin-bottom="10mm"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start region-name="xsl-region-start" extent="150mm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="content-page-master" page-height="297mm" page-width="210mm"
          margin-top="20mm" margin-bottom="20mm" margin-left="15mm" margin-right="35mm">
          <fo:region-body region-name="xsl-region-body" margin-top="15mm" margin-bottom="10mm"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start region-name="xsl-region-start" extent="150mm"/>
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
        <fo:flow>
          <fo:block text-align="center">
          <fo:external-graphic src="http://utf-x.sourceforge.net/images/utf-x.gif" width="250px"/>
          </fo:block>
          <fo:block font-size="38pt" font-weight="bold" color="brown" text-align="right">
            <xsl:value-of select="u:title"/>
          </fo:block>
          <fo:block font-size="28pt" font-weight="bold" color="brown" text-align="right">
            <xsl:value-of select="u:subtitle"/>
          </fo:block>
          <fo:block space-before="60mm"/>
          <xsl:apply-templates select="u:author"/>
          <fo:block font-size="12pt" text-align="left">
            <xsl:value-of select="./u:version"/>
          </fo:block>
          <fo:block font-size="12pt" text-align="left">
            <xsl:value-of select="./u:date"/>
          </fo:block>          
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="toc-sequence-master">
        <fo:flow>
          <xsl:call-template name="print-toc"/>
        </fo:flow>
      </fo:page-sequence>
      
      <fo:page-sequence master-reference="content-page-master">
        <!-- render the header, page number and stylesheet name -->
        <fo:static-content flow-name="xsl-region-start">
          <fo:block text-align="left" color="black" background-color="white" font-family="Helvetica"
            font-size="8.5pt">
            <fo:inline font-weight="bold">
              <xsl:text>Page </xsl:text>
              <fo:page-number/>
            </fo:inline>
            <fo:inline>
              <xsl:text> - </xsl:text>
              <xsl:value-of select="u:title"/>
            </fo:inline>
            <fo:inline text-align="center" color="grey" font-style="italic">&#160; XML document
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
    <fo:block font-size="12pt" text-align="left">
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
  <!-- empty templates -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:title"/>
  <xsl:template match="u:version"/>
  <xsl:template match="u:date"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <para> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:para">
    <fo:block xsl:use-attribute-sets="block" font-size="12pt" text-align="left"
      font-family="Helvetica">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <note> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:note">
    <fo:block padding-top="2mm" padding-left="2mm" padding-bottom="2mm" padding-right="2mm"
      background-color="#AAEEDD">
      <fo:inline font-weight="bold">NOTE</fo:inline>
      <fo:block xsl:use-attribute-sets="block" font-size="10pt" text-align="left"
        font-family="Helvetica">
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
        <fo:list-item space-before="2mm" space-after="2mm">
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
    <fo:list-item space-before="2mm" space-after="2mm">
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
    <fo:block xsl:use-attribute-sets="block" font-family="Courier" white-space-treatment="preserve"
      linefeed-treatment="preserve" white-space-collapse="false" color="brown" font-size="8pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <code> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:code">
    <fo:inline font-family="Courier" color="#003399" font-size="10pt">
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
        <xsl:value-of select="//*[@id=$idref]/@number"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="//*[@id=$idref]/u:title"/>
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
  <!-- figure -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:figure">
    <fo:block xsl:use-attribute-sets="block" text-align="center">
      <fo:block>
        <xsl:apply-templates select="u:img | u:xml | u:svg"/>
      </fo:block>
      <fo:block>
        <xsl:apply-templates select="u:caption"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <caption> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:caption">
    <fo:block text-align="left" padding-left="2mm" padding-top="1mm">
      <fo:inline font-weight="bold">Figure <xsl:value-of select="../@number"/>
        <xsl:text>: </xsl:text></fo:inline>
      <xsl:apply-templates/>
    </fo:block>
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
  <!-- <img> - Image -->
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
    <fo:list-item space-before="2mm" space-after="2mm">
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
    <fo:block xsl:use-attribute-sets="code-block">
      <xsl:apply-templates select="*" mode="xmlverb"/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Print Table of Contents  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-toc">
    <fo:block xsl:use-attribute-sets="h1">
      <xsl:text>Table of Contents</xsl:text>
    </fo:block>
    <fo:block>
      <xsl:for-each select="//u:sect1">
        <fo:block margin-left="5mm" font-size="14pt" space-before="3pt">
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
        <xsl:for-each select=".//u:sect2">
          <fo:block margin-left="15mm" font-size="12pt" space-before="2pt">
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
          <xsl:for-each select=".//u:sect3">
            <fo:block margin-left="25mm" font-size="10pt" space-before="1pt">
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
