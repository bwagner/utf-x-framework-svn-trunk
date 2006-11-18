<?xml version="1.0" encoding="UTF-8"?>
<!--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 $Id$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
 Purpose: address book sample xhtml stylesheet
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright(C) 2004-2006 UTF-X development team.
	
 You may redistribute and/or modify this file under the terms of the
 GNU General Public License v2.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- stylesheet parameters -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:param name="color"/>
  
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- root template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- address-book template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="address-book">
    <html>
      <head>
        <title>Address Book</title>
        <style type="text/css"><![CDATA[
.last-name {font-weight: bold;}
.middle-name {}
.first-name {font-style: italic;}
]]></style>
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:text>font-family: Arial;</xsl:text>
          <xsl:if test="string-length($color) &gt; 0">
            <xsl:value-of select="concat(' color: ', $color, ';')"/>
          </xsl:if>
        </xsl:attribute>
        <center>
          <h1>Address Book</h1>

          <table width="70%" border="1">
            <colgroup>
              <col width="33%"/>
              <col width="33%"/>
              <col width="33%"/>
            </colgroup>
            <tbody>
              <tr>
                <th>Name</th>
                <th>Address</th>
                <th>Telephone Numbers</th>
              </tr>
              <xsl:for-each select="address-entry">
                <xsl:sort select="person/last-name"/>
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </tbody>
          </table>
        </center>
      </body>
    </html>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- address-entry template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="address-entry">
    <tr>
      <td valign="top">
        <span class="last-name">
          <xsl:value-of select="person/last-name"/>
        </span>
        <xsl:text>, </xsl:text>
        <span class="first-name">
          <xsl:value-of select="person/first-name"/>
        </span>
        <xsl:text> </xsl:text>
        <span class="middle-name">
          <xsl:value-of select="person/middle-name"/>
        </span>
      </td>
      <td>
        <xsl:apply-templates select="street-address"/>
      </td>
      <td>
        <xsl:call-template name="telephone-numbers">
          <xsl:with-param name="address-entry" select="."/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- street-address template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="street-address">
    <table>
      <tbody>
        <tr>
          <td>
            <xsl:value-of select="street"/>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:value-of select="city"/>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:value-of select="state"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="post-code"/>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:value-of select="country"/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- telephone numbers template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="telephone-numbers">
    <xsl:param name="address-entry"/>
    <table>
      <tbody>
        <tr>
          <td>
            <xsl:text>Home: </xsl:text>
          </td>
          <td>
            <xsl:call-template name="telephone-number">
              <xsl:with-param name="telephone-number" select="./home-telephone"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:text>Mobile: </xsl:text>
          </td>
          <td>
            <xsl:call-template name="telephone-number">
              <xsl:with-param name="telephone-number" select="./mobile-telephone"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td>
            <xsl:text>Work: </xsl:text>
          </td>
          <td>
            <xsl:call-template name="telephone-number">
              <xsl:with-param name="telephone-number" select="./work-telephone"/>
            </xsl:call-template>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- output telephone number -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="telephone-number">
    <xsl:param name="telephone-number"/>
    <xsl:variable name="telephone-number-nodeset" select="exsl:node-set($telephone-number)"/>
    <xsl:choose>
      <xsl:when test="$telephone-number-nodeset/area-code">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="$telephone-number-nodeset/area-code"/>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$telephone-number-nodeset/area-code"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="$telephone-number-nodeset/number"/>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text() template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
