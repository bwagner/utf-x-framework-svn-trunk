<?xml version="1.0" encoding="UTF-8"?>
<!--
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: test_definition_fo.xsl,v 1.4.2.8 2006/08/23 12:39:02 jacekrad Exp $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: this stylesheet is used to generate XSL:FO (.fo) output from a UTF-X 
          definition file.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Copyright(C) 2006 UTF-X Development Team.
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License v2 as published
  by the Free Software Foundation (http://www.gnu.org/licenses/gpl.txt)
  
  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.
  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:rx="http://www.renderx.com/XSL/Extensions" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:utfx="http://utfx.org/test-definition">

  <xsl:import href="xmlverbatim_fo.xsl"/>

  <!-- the following attribute sets correspond to the CSS styles used
       in XHTML version of this stylesheet -->

  <xsl:attribute-set name="utfx-sect">
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="background-color">#FFFFFF</xsl:attribute>
    <xsl:attribute name="border-left-width">20pt</xsl:attribute>
    <xsl:attribute name="border-left-color">#FFFFFF</xsl:attribute>
    <xsl:attribute name="border-left-style">solid</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-test"/>

  <xsl:attribute-set name="utfx-source-fragment">
    <xsl:attribute name="padding-top">3mm</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="border-color">brown</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-width">1pt</xsl:attribute>
    <xsl:attribute name="width">80%</xsl:attribute>
    <xsl:attribute name="background-color">#FFFFCC</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-expected-fragment">
    <xsl:attribute name="padding-top">3mm</xsl:attribute>
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="border-color">#009900</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-width">1pt</xsl:attribute>
    <xsl:attribute name="width">80%</xsl:attribute>
    <xsl:attribute name="background-color">#CCFFCC</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-expected-rendition">
    <xsl:attribute name="border-color">#009900</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-width">1pt</xsl:attribute>
    <xsl:attribute name="width">100%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-h1">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-size">13pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="padding-top">8mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-h2">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="padding-top">5mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-h3">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="padding-top">5mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-h4">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="padding-top">5mm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-code">
    <xsl:attribute name="font-family">Courier</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">#2200AB</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-not-rendering-message">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="utfx-failure-message">
    <xsl:attribute name="font-family">Arial, Helvetica, sans-serif</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="color">red</xsl:attribute>
  </xsl:attribute-set>

  <!-- the following are used by the table which lists the tests -->
  <xsl:attribute-set name="table-cell">
    <xsl:attribute name="display-align">center</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="border-width">.1mm</xsl:attribute>
    <xsl:attribute name="border-color">black</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="padding">.5mm</xsl:attribute>
  </xsl:attribute-set>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>

        <fo:simple-page-master master-name="Page" page-height="297mm" page-width="210mm"
          margin-top="20mm" margin-bottom="20mm" margin-left="10mm" margin-right="10mm">
          <fo:region-body region-name="xsl-region-body" margin-top="15mm" margin-bottom="10mm"/>
          <fo:region-start region-name="xsl-region-start" extent="150mm"/>
          <fo:region-after extent="5mm"/>
        </fo:simple-page-master>

        <!-- define page sequence -->
        <fo:page-sequence-master master-name="PageSequence">
          <fo:repeatable-page-master-reference master-reference="Page"/>
        </fo:page-sequence-master>

      </fo:layout-master-set>

      <!--
      RenderX XEP extensions; we don't have XEP
      <xsl:call-template name="bookmarks"/>
      -->
      <!-- for each test ... -->
      <xsl:for-each select="//utfx:test">
        <fo:page-sequence master-reference="PageSequence">

          <!-- render the header: page number, stylesheet name and a link to UTF-X -->
          <fo:static-content flow-name="xsl-region-start">
            <fo:table>
              <fo:table-column column-width="94mm"/>
              <fo:table-column column-width="94mm"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell text-align="left">
                    <fo:block text-align="left" color="black" background-color="white"
                      font-family="Helvetica" font-size="8.5pt">
                      <fo:inline font-weight="bold" font-size="9pt">
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                      </fo:inline>
                      <fo:inline font-size="9pt">
                        <xsl:text> -  Test definition for </xsl:text>
                      </fo:inline>
                      <fo:inline font-weight="bold" font-family="Courier" font-size="9pt">
                        <xsl:value-of select="//utfx:stylesheet/@src"/>
                      </fo:inline>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell text-align="right">
                    <fo:block color="blue" font-size="9pt">
                      <fo:basic-link>
                        <xsl:attribute name="external-destination">
                          <xsl:text>http://utf-x.sourceforge.net</xsl:text>
                        </xsl:attribute>
                        <xsl:text>UTF-X.SourceForge.net</xsl:text>
                      </fo:basic-link>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:static-content>
          <!-- end of header -->

          <fo:flow flow-name="xsl-region-body">
            <!-- if this is the first page then we show the stylesheet and dtd -->
            <xsl:if test="position() = 1">
              <xsl:call-template name="preamble"/>
            </xsl:if>

            <!-- and now we render all tests -->
            <fo:block xsl:use-attribute-sets="utfx-test">
              <xsl:attribute name="id">
                <xsl:text>test</xsl:text>
                <xsl:number value="position()" format="1"/>
              </xsl:attribute>
              <fo:block xsl:use-attribute-sets="utfx-h1">
                <xsl:number value="position()" format="1"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="utfx:name"/>
              </fo:block>
              <xsl:apply-templates/>
            </fo:block>
          </fo:flow>
        </fo:page-sequence>
      </xsl:for-each>
      <xsl:call-template name="print-notes"/>
    </fo:root>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- test template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:test">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- name template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:name"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- assert equals template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:assert-equals">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- stylesheet parameters -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:stylesheet-params">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">Stylesheet parameters:</fo:block>
      <fo:block xsl:use-attribute-sets="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb" select="."/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- call template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:call-template">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">Call template:</fo:block>
      <fo:block xsl:use-attribute-sets="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb" select="."/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- source template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:source">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">Source:</fo:block>
      <xsl:if test="./@validate='yes' and (//utfx:source-validation != '')">
        <xsl:text>this source fragment will be validated using </xsl:text>
        <fo:inline xsl:use-attribute-sets="utfx-code">PUBLIC <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@public"/>
        </fo:inline>
        <fo:inline xsl:use-attribute-sets="utfx-code"> "<xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@system"/>"</fo:inline>
      </xsl:if>
      <fo:block xsl:use-attribute-sets="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- expected template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:expected">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">Expected:</fo:block>
      <xsl:if test="./@validate='yes' and (//utfx:expected-validation != '')">
        <xsl:text>this expected fragment will be validated using </xsl:text>
        <fo:inline xsl:use-attribute-sets="utfx-code">PUBLIC <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@public"/>
        </fo:inline>
        <fo:inline xsl:use-attribute-sets="utfx-code"> "<xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@system"/>"</fo:inline>
      </xsl:if>
      <fo:block xsl:use-attribute-sets="utfx-expected-fragment">
        <xsl:apply-templates mode="xmlverb"/>
      </fo:block>
      <fo:block xsl:use-attribute-sets="utfx-h4">Expected Rendition:</fo:block>
    </fo:block>
    <xsl:choose>
      <xsl:when test="./@validate = 'yes'">
        <fo:block xsl:use-attribute-sets="utfx-expected-rendition">
          <xsl:copy-of select="child::*"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline xsl:use-attribute-sets="utfx-not-rendering-message">Not rendering expected
          because validate="no". </fo:inline>
        <fo:inline color="blue" font-style="italic">
          <fo:basic-link internal-destination="note1">
            <xsl:text>see Note 1.</xsl:text>
          </fo:basic-link>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- message template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:message">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">Failure message:</fo:block>
      <fo:inline xsl:use-attribute-sets="utfx-failure-message">
        <xsl:value-of select="."/>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- named template to create a simple table of contents -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="preamble">

    <xsl:variable name="source-validation" select="boolean(//utfx:source-validation != '')"/>
    <xsl:variable name="expected-validation" select="boolean(//utfx:expected-validation != '')"/>
    <xsl:variable name="custom-builder-defined" select="/utfx:tests/utfx:source-builder != ''"/>

    <fo:block xsl:use-attribute-sets="utfx-sect">

      <!-- display source validation details if any -->
      <xsl:if test="$source-validation">
        <fo:block xsl:use-attribute-sets="utfx-h2">Source fragment validation</fo:block>
        <fo:block xsl:use-attribute-sets="utfx-code">PUBLIC: <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@public"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="utfx-code">SYSTEM: <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@system"/>
        </fo:block>
      </xsl:if>

      <!-- display expected validation details if any -->
      <xsl:if test="$expected-validation">
        <fo:block xsl:use-attribute-sets="utfx-h2">Expected fragment validation</fo:block>
        <fo:block xsl:use-attribute-sets="utfx-code">PUBLIC: <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@public"/>
        </fo:block>
        <fo:block xsl:use-attribute-sets="utfx-code">SYSTEM: <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@system"/>
        </fo:block>
      </xsl:if>

      <!-- source builder -->
      <xsl:if test="$custom-builder-defined">
        <fo:block xsl:use-attribute-sets="utfx-h2">Global custom SourceBuilder (parser)</fo:block>
        <xsl:apply-templates select="/utfx:tests/utfx:source-builder"/>
      </xsl:if>



      <fo:block xsl:use-attribute-sets="utfx-h2">List of tests</fo:block>
      <fo:block font-size="10pt">
        <fo:table>
          <fo:table-column column-width="10mm"/>
          <fo:table-column column-width="90mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-body>

            <!-- table header -->
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="table-cell">
                <fo:block>Num.</fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="table-cell">
                <fo:block>Test Name</fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="table-cell">
                <fo:block>Validate source</fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="table-cell">
                <fo:block>Validate expected</fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="table-cell">
                <fo:block>Use custom source parser</fo:block>
              </fo:table-cell>
            </fo:table-row>

            <!-- for each display number, name and if the source and/or expected is to be
                 validated and if custom source parser is to be used -->
            <xsl:for-each select="//utfx:test">
              <fo:table-row>

                <!-- test number -->
                <fo:table-cell xsl:use-attribute-sets="table-cell" text-align="right">
                  <fo:block color="blue">
                    <fo:basic-link>
                      <xsl:attribute name="internal-destination">
                        <xsl:text>test</xsl:text>
                        <xsl:value-of select="position()"/>
                      </xsl:attribute>
                      <xsl:number value="position()" format="1"/>
                    </fo:basic-link>
                  </fo:block>
                </fo:table-cell>

                <!-- test name -->
                <fo:table-cell xsl:use-attribute-sets="table-cell" text-align="left">
                  <fo:block>
                    <xsl:value-of select="./utfx:name"/>
                  </fo:block>
                </fo:table-cell>

                <!-- is source to be validated for this test -->
                <fo:table-cell xsl:use-attribute-sets="table-cell">
                  <fo:block>
                    <xsl:choose>
                      <xsl:when test="$source-validation">
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select=".//utfx:source/@validate"/>
                        </xsl:call-template>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select="'&#8212;'"/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>

                <!-- is expected to be validated for this test -->
                <fo:table-cell xsl:use-attribute-sets="table-cell">
                  <fo:block>
                    <xsl:choose>
                      <xsl:when test="$expected-validation">
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select=".//utfx:expected/@validate"/>
                        </xsl:call-template>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select="'&#8212;'"/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>

                <!-- is custom source parser to be used for this test -->
                <fo:table-cell xsl:use-attribute-sets="table-cell">
                  <fo:block>
                    <xsl:choose>
                      <xsl:when test="$custom-builder-defined or (./utfx:source-builder != '')">
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select=".//utfx:source/@use-source-parser"/>
                        </xsl:call-template>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="yes-no">
                          <xsl:with-param name="answer" select="'&#8212;'"/>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>

              </fo:table-row>
            </xsl:for-each>
          </fo:table-body>
        </fo:table>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- source builder at TDF level -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:tests/utfx:source-builder">
    <xsl:call-template name="render-source-builder"/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- source builder in a test template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:test/utfx:source-builder">
    <fo:block xsl:use-attribute-sets="utfx-sect">
      <fo:block xsl:use-attribute-sets="utfx-h4">This source fragment will be parsed by source
        builder: </fo:block>
      <xsl:call-template name="render-source-builder"/>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- render the actual source builder  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="render-source-builder">
    <fo:block xsl:use-attribute-sets="utfx-code">
      <xsl:variable name="number-of-params" select="count(.//utfx:param)"/>
      <xsl:value-of select="./utfx:class-name"/>
      <xsl:text> sourceBuilder = new </xsl:text>
      <xsl:value-of select="./utfx:class-name"/>
      <xsl:text>(</xsl:text>
      <xsl:for-each select=".//utfx:param">
        <xsl:value-of select="."/>
        <xsl:if test="position() != $number-of-params">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:text>);</xsl:text>
    </fo:block>
  </xsl:template>


  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- template to print YES, NO or the content of $answer if $answer is neither
    'yos' nor 'no. -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="yes-no">
    <xsl:param name="answer"/>
    <xsl:choose>
      <xsl:when test="$answer = 'yes'">
        <fo:inline color="green">YES</fo:inline>
      </xsl:when>
      <xsl:when test="$answer = 'no'">
        <fo:inline color="red">NO</fo:inline>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline font-weight="bold">
          <xsl:value-of select="$answer"/>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!--  print notes (legend) -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="print-notes">
    <fo:page-sequence master-reference="PageSequence">

      <!-- render the header: page number, stylesheet name and a link to UTF-X -->
      <fo:static-content flow-name="xsl-region-start">
        <fo:table>
          <fo:table-column column-width="94mm"/>
          <fo:table-column column-width="94mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell text-align="left">
                <fo:block text-align="left" color="black" background-color="white"
                  font-family="Helvetica" font-size="8.5pt">
                  <fo:inline font-weight="bold" font-size="9pt">
                    <xsl:text>Page </xsl:text>
                    <fo:page-number/>
                  </fo:inline>
                  <fo:inline font-size="9pt">
                    <xsl:text> -  Test definition for </xsl:text>
                  </fo:inline>
                  <fo:inline font-weight="bold" font-family="Courier" font-size="9pt">
                    <xsl:value-of select="//utfx:stylesheet/@src"/>
                  </fo:inline>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block color="blue" font-size="9pt">
                  <fo:basic-link>
                    <xsl:attribute name="external-destination">
                      <xsl:text>http://utf-x.sourceforge.net</xsl:text>
                    </xsl:attribute>
                    <xsl:text>UTF-X.SourceForge.net</xsl:text>
                  </fo:basic-link>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:static-content>
      <!-- end of header -->

      <fo:flow flow-name="xsl-region-body">
        <fo:block xsl:use-attribute-sets="utfx-h2">Notes</fo:block>
        <fo:block id="note1">
          <fo:inline xsl:use-attribute-sets="utfx-h4">Note 1: </fo:inline>
          <fo:inline font-size="6pt">Expected fragments that have the validate attribute set to 'no'
            will not be rendered. The reasoning behind this is that if the expected fragment cannot
            be validated then it also cannot be rendered. There are two common reasons why you would
            want to disablle validation (and therefore rendering) The first scenario is when a test
            transform generates a complete XSL:FO document, i.e. the root element is
            &lt;fo:root&gt;. Because UTF-X validates the expected XSL:FO fragment by
            wrapping it's contents in &lt;fo:block&gt;, rendition (and validation) would
            fail in this case as the &lt;fo:block&gt; element would contain a
            &lt;fo:root&gt;. XSL:FO engines are far less forgiving than HTML browsers.
            Another scenario where you don't want to attempt validation or rendition of expected, is
            when your test is at low level and higher level structure is incomplete. A good example
            of this is a test which generates a table row. Table row cannot be redered without the
            rest of the table.</fo:inline>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- Generate bookmarks ... RenderX XEP only -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="bookmarks">
    <rx:outline>
      <xsl:for-each select="//utfx:test">
        <rx:bookmark>
          <xsl:attribute name="internal-destination">
            <xsl:text>test</xsl:text>
            <xsl:number value="position()" format="1"/>
          </xsl:attribute>
          <rx:bookmark-label>
            <xsl:number value="position()" format="1"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="./utfx:name"/>
          </rx:bookmark-label>
        </rx:bookmark>
      </xsl:for-each>
    </rx:outline>
  </xsl:template>
</xsl:stylesheet>
