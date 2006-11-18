<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: test_definition_xhtml.xsl,v 1.9.2.12 2006/08/23 12:54:06 jacekrad Exp $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: this stylesheet is used to render HTML output from a UTF-X definition
          file.
	
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:utfx="http://utfx.org/test-definition" version="1.0">
  <xsl:import href="xmlverbatim_xhtml.xsl"/>
  <xsl:output method="html"/>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- root template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="/">
    <html>
      <head>
        <xsl:apply-templates select="//utfx:css"/>
        <!-- prefix local CSS styles with utfx so there is less of a chance of a
        name conflict with the imported CSS stylesheet (if any). All HTML elements
        need to be explicitly styled to avoid CSS styles from the imported stylesheet
        being leaked in - issue 22 -->
        <style type="text/css">
.utfx-sect {
  background-color:#FFFFFF;
  border-left-width:20pt;
  border-left-color:#FFFFFF;
  border-left-style:solid;
}
.utfx-test {

}
.utfx-source-fragment {
  border-color:brown;
  font-family:Courier;
  border-style:solid;
  border-width:2;
  width:80%;
  background-color:#FFFFCC;
}
.utfx-expected-fragment {
  border-color:009900;
  font-family:Courier;
  border-style:solid;
  border-width:2;
  width:80%;
  background-color:#CCFFCC;
}
.utfx-expected-rendition {
  border-color:009900;
  border-style:solid;
  border-width:2;
  width:100%;
}
.utfx-h1 {
	font-family: Arial;
	font-size: 18pt;
	color: black;
  padding-top:8mm;	
}
.utfx-h2 {
  font-family: Arial;
  font-size: 16pt;
  color: black;
  padding-top:5mm;
}
.utfx-h3 {
  font-family: Arial;
  font-size: 14pt;
  color: black;
  padding-top:5mm;  
}
.utfx-h4 {
  font-family: Arial;
  font-size: 12pt;
  color: black;
  font-weight: bold;
  padding-top:5mm;  
}
.utfx-code {
  font-family: Courier;
  font-size:9pt;
  color: 2200AB;
}
.utfx-not-rendering-message {
  font-family:Arial;
  font-style:italic;
  color:blue;
}
.utfx-failure-message {
  font-family:Arial;
  font-style:italic;
  color:red;
}
/* xml verbatim styles */
.xmlverb-default { 
  color: #334455; background-color:red;
   font-family: Courier;
}
.xmlverb-element-name     { color: #990000;}
.xmlverb-element-nsprefix { color: #666600;}
.xmlverb-attr-name        { color: #660000;}
.xmlverb-attr-content     { color: #000099; font-weight: bold;}
.xmlverb-ns-name          { color: #666600;}
.xmlverb-ns-uri           { color: #330099;}
.xmlverb-text             { color: #000000; font-weight: bold;}
.xmlverb-comment          { color: #006600; font-style: italic;}
.xmlverb-pi-name          { color: #006600; font-style: italic;}
.xmlverb-pi-content       { color: #006666; font-style: italic;}   
        </style>
      </head>
      <body bgcolor="#FFFFFF" style="font-family:Arial;">

        <!-- generate a simple table of contents -->
        <xsl:call-template name="preamble"/>
        <!-- here we render each test element -->
        <xsl:for-each select="//utfx:test">
          <div class="utfx-test">
            <a>
              <xsl:attribute name="name">
                <xsl:text>test</xsl:text>
                <xsl:number value="position()" format="1"/>
              </xsl:attribute>
            </a>
            <div class="utfx-h1">
              <xsl:number value="position()" format="1"/>
              <xsl:text>. </xsl:text>
              <xsl:value-of select="utfx:name"/>
            </div>
            <xsl:apply-templates/>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- utfx:css -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:css">
    <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:value-of select="./@uri"/>
      </xsl:attribute>
    </link>
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
  <xsl:template match="utfx:assert-equal">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- stylesheet parameters-->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:stylesheet-params">
    <div class="utfx-sect">
      <div class="utfx-h4">Stylesheet parameters:</div>
      <div class="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb" select="."/>
      </div>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- call template template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:call-template">
    <div class="utfx-sect">
      <div class="utfx-h4">Call template:</div>
      <div class="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb" select="."/>
      </div>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- source template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:source">
    <div class="utfx-sect">
      <div class="utfx-h4">Source:</div>
      <xsl:if test="./@validate='yes' and (//utfx:source-validation != '')">
        <xsl:text>this source fragment will be validated using </xsl:text>
        <span class="utfx-code">PUBLIC <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@public"/>
        </span>
        <span class="utfx-code"> "<xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@system"/>"</span>
      </xsl:if>
      <div class="utfx-source-fragment">
        <xsl:apply-templates mode="xmlverb"/>
      </div>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- expected template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:expected">
    <div class="utfx-sect">
      <div class="utfx-h4">Expected:</div>
      <xsl:if test="./@validate='yes' and (//utfx:expected-validation != '')">
        <xsl:text>this expected fragment will be validated using </xsl:text>
        <span class="utfx-code">PUBLIC <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@public"/>
        </span>
        <span class="utfx-code"> "<xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@system"/>"</span>
      </xsl:if>
      <div class="utfx-expected-fragment">
        <xsl:apply-templates mode="xmlverb"/>
      </div>
      <div class="utfx-h4">Expected Rendition:</div>
    </div>
    <xsl:choose>
      <xsl:when test="./@validate = 'yes'">
        <div class="utfx-expected-rendition">
          <xsl:copy-of select="."/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="utfx-not-rendering-message">Not rendering expected because
          validate="no"</div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- message template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="utfx:message">
    <div class="utfx-sect">
      <div class="utfx-h4">Failure message:</div>
      <span>This message will be shown if this test fails: </span>
      <span class="utfx-failure-message">
        <xsl:value-of select="."/>
      </span>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- named template to create a preamble including a simple table of contents -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="preamble">

    <xsl:variable name="source-validation"
      select="boolean(//utfx:source-validation != '')"/>
    <xsl:variable name="expected-validation"
      select="boolean(//utfx:expected-validation != '')"/>
    <xsl:variable name="custom-builder-defined"
      select="/utfx:tests/utfx:source-builder != ''"/>

    <div class="utfx-sect">
      <!-- heading -->
      <table cellpadding="5" width="100%">
        <colgroup width="20%"/>
        <colgroup width="20%"/>
        <colgroup width="60%"/>
        <tbody>
          <tr>
            <th align="left">UTF-X Test Definition File for: </th>
            <td align="left">
              <div class="utfx-code">
                <xsl:value-of select="//utfx:stylesheet/@src"/>
              </div>
            </td>
            <td align="right">
              <a href="http://utf-x.sourceforge.net">UTF-X.SourceForge.net</a>
            </td>
          </tr>
        </tbody>
      </table>
      <hr/>

      <!-- display source validation details if any -->
      <xsl:if test="$source-validation">
        <div class="utfx-h2">Source fragment validation</div>
        <div class="utfx-code">PUBLIC: <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@public"/>
        </div>
        <div class="utfx-code">SYSTEM: <xsl:value-of
            select="//utfx:source-validation/utfx:dtd/@system"/>
        </div>
      </xsl:if>

      <!-- display expected validation details if any -->
      <xsl:if test="$expected-validation">
        <div class="utfx-h2">Expected fragment validation</div>
        <div class="utfx-code">PUBLIC: <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@public"/>
        </div>
        <div class="utfx-code">SYSTEM: <xsl:value-of
            select="//utfx:expected-validation/utfx:dtd/@system"/>
        </div>
      </xsl:if>

      <!-- source builder -->
      <xsl:if test="$custom-builder-defined">
        <div class="utfx-h2">Global custom SourceBuilder (parser)</div>
        <xsl:apply-templates select="/utfx:tests/utfx:source-builder"/>
      </xsl:if>

      <!-- CSS stylesheet if any -->
      <xsl:if test="//utfx:css/@uri != ''">
        <div class="utfx-h2">Cascading StyleSheet</div>
        <xsl:text>CSS applied to expected rendition: </xsl:text>
        <span class="utfx-code">
          <xsl:value-of select="//utfx:css/@uri"/>
        </span>
      </xsl:if>

      <!-- table of contents -->
      <div class="utfx-h2">List of tests</div>
      <table border="1" cellpadding="4">
        <tbody>
          <!--table header -->
          <tr>
            <th>Num.</th>
            <th>Test name</th>
            <th>Validate source</th>
            <th>Validate expected</th>
            <th>Use custom source parser</th>
          </tr>
          <xsl:for-each select="//utfx:test">
            <tr>
              <!-- test number -->
              <th align="right">
                <!-- create a link to each test -->
                <a>
                  <xsl:attribute name="href">
                    <xsl:text>#test</xsl:text>
                    <xsl:number value="position()" format="1"/>
                  </xsl:attribute>
                  <xsl:number value="position()" format="1"/>
                </a>
              </th>
              <!-- test name -->
              <td align="left">
                <xsl:value-of select="./utfx:name"/>
              </td>

              <!-- is source validated for this test -->
              <td align="center">
                <xsl:choose>
                  <xsl:when test="$source-validation">
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer"
                        select=".//utfx:source/@validate"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer" select="'&#8212;'"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </td>

              <!-- is expected fragment validated for this test -->
              <td align="center">
                <xsl:choose>
                  <xsl:when test="$expected-validation">
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer"
                        select=".//utfx:expected/@validate"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer" select="'&#8212;'"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </td>

              <!-- is source builder used for parsing the source fragment in this test -->
              <td align="center">
                <xsl:choose>
                  <xsl:when
                    test="$custom-builder-defined or (./utfx:source-builder != '')">
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer"
                        select=".//utfx:source/@use-source-parser"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="yes-no">
                      <xsl:with-param name="answer" select="'&#8212;'"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
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
    <div class="utfx-sect">
      <div class="utfx-h4">This source fragment will be parsed by source
        builder: </div>
      <xsl:call-template name="render-source-builder"/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- render the actual source builder  -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="render-source-builder">
    <div class="utfx-code">
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
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- template to print YES, NO or the content of $answer if $answer is neither
       'yos' nor 'no. -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="yes-no">
    <xsl:param name="answer"/>
    <xsl:choose>
      <xsl:when test="$answer = 'yes'">
        <span style="color:green;">YES</span>
      </xsl:when>
      <xsl:when test="$answer = 'no'">
        <span style="color:red">NO</span>
      </xsl:when>
      <xsl:otherwise>
        <span style="font-weight:bold">
          <xsl:value-of select="$answer"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
