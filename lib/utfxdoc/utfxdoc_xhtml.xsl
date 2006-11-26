<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id: utfxdoc_xhtml.xsl 88 2006-11-25 07:05:29Z jacekrad $
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: UTF-X documentation xhtml stylesheet
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright(C) 2004-2006 UTF-X Development Team.
	
 You may redistribute and/or modify this file under the terms of the
 GNU General Public License v2.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:u="http://utf-x.sourceforge.net/xsd/utfxdoc_1_0/utfxdoc.xsd">
  <xsl:import href="xmlverbatim_xhtml.xsl"/>

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
        <title>
          <xsl:value-of select="./u:title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="http://utf-x.sourceforge.net/xsl/utfxdoc_1_0/utfxdoc.css"/>
      </head>
      <body>
        <div class="title">
          <xsl:value-of select="u:title"/>
        </div>
        <div class="subtitle">
          <xsl:value-of select="u:subtitle"/>
        </div>
        <xsl:apply-templates select="u:author"/>
        <div class="version">
          <xsl:value-of select="u:version"/>
        </div>
        <div class="date">
          <xsl:value-of select="u:date"/>
        </div>
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
    <div class="author">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- <sect1> -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="u:sect1">
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
    <div class="note">
      <span style="font-size:12pt; font-weight:bold;">NOTE</span>
      <div class="u:note">
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
      <xsl:value-of select="//*[@id=$idref]/@number"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="//*[@id=$idref]/u:title"/>
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
  <xsl:template match="u:figure">
    <div class="figure">
      <div class="figure-block">
        <xsl:apply-templates select="u:img | u:xml | u:svg"/>
      </div>
      <div class="caption">
        <span style="font-weight:bold;">
          <xsl:text>Figure </xsl:text>
          <xsl:value-of select="@number"/>
          <xsl:text>: </xsl:text>
        </span>
        <xsl:apply-templates select="u:caption"/>
      </div>
    </div>
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
      <xsl:if test="@widht != ''">
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
    <div class="code-block">
      <xsl:apply-templates select="*" mode="xmlverb"/>
    </div>
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
    <div class="toc">
      <table width="80%">
        <colgroup>
          <col align="left" width="2%"/>
          <col align="left" width="2%"/>
          <col align="left" width="96%"/>
        </colgroup>
        <tbody>

          <!-- section -->
          <xsl:for-each select="//u:sect1">
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
            <xsl:for-each select=".//u:sect2">
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
              <xsl:for-each select=".//u:sect3">
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
</xsl:stylesheet>
