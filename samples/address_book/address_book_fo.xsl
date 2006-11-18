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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0" xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">

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
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master margin-right="35mm" margin-left="15mm" margin-bottom="20mm"
          margin-top="20mm" page-width="210mm" page-height="297mm" master-name="Page">
          <fo:region-body margin-bottom="10mm" margin-top="15mm" region-name="xsl-region-body"/>
          <fo:region-after extent="5mm"/>
          <fo:region-start extent="150mm" region-name="xsl-region-start"/>
        </fo:simple-page-master>
        <fo:page-sequence-master master-name="PageSequence">
          <fo:repeatable-page-master-reference master-reference="Page"/>
        </fo:page-sequence-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="PageSequence">
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="24pt" text-align="center">Address Book</fo:block>
          <fo:block>
            <fo:table>
              <fo:table-column column-width="60mm"/>
              <fo:table-column column-width="60mm"/>
              <fo:table-column column-width="60mm"/>
              <fo:table-header>
                <fo:table-row>
                  <fo:table-cell border-width="1pt" border-color="black" border-style="solid"
                    text-align="center" font-weight="bold">
                    <fo:block padding="1mm">Name</fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-width="1pt" border-color="black" border-style="solid"
                    text-align="center" font-weight="bold">
                    <fo:block padding="1mm">Address</fo:block>
                  </fo:table-cell>
                  <fo:table-cell border-width="1pt" border-color="black" border-style="solid"
                    text-align="center" font-weight="bold">
                    <fo:block padding="1mm">Telephone Numbers</fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-header>
              <fo:table-body>
                <xsl:for-each select="address-entry">
                  <xsl:sort select="person/last-name"/>
                  <xsl:apply-templates select="."/>
                </xsl:for-each>
              </fo:table-body>
            </fo:table>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- address-entry template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="address-entry">
    <fo:table-row>
      <fo:table-cell border-width="1pt" border-color="black" border-style="solid">
        <xsl:apply-templates select="person"/>
      </fo:table-cell>
      <fo:table-cell border-width="1pt" border-color="black" border-style="solid">
        <xsl:apply-templates select="street-address"/>
      </fo:table-cell>
      <fo:table-cell border-width="1pt" border-color="black" border-style="solid">
        <xsl:call-template name="telephone-numbers">
          <xsl:with-param name="address-entry" select="."/>
        </xsl:call-template>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- person template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="person">
    <fo:block padding="1mm">
      <fo:inline font-weight="bold"><xsl:value-of select="./last-name"/>, </fo:inline>
      <fo:inline font-style="italic">
        <xsl:value-of select="./first-name"/>
        <xsl:text> </xsl:text>
      </fo:inline>
      <fo:inline>
        <xsl:value-of select="./middle-name"/>
      </fo:inline>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- street address template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="street-address">
    <fo:block padding="1mm">
      <fo:table>
        <fo:table-column column-width="55mm"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="street"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="city"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="state"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="post-code"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="country"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- telephone numbers template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="telephone-numbers">
    <xsl:param name="address-entry"/>
    <fo:block padding="1mm">
      <fo:table>
        <fo:table-column column-width="15mm"/>
        <fo:table-column column-width="30mm"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>Home:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <xsl:call-template name="telephone-number">
                <xsl:with-param name="telephone-number" select="./home-telephone"/>
              </xsl:call-template>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>Mobile:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <xsl:call-template name="telephone-number">
                <xsl:with-param name="telephone-number" select="./mobile-telephone"/>
              </xsl:call-template>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <fo:table-cell>
              <fo:block>Work:</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <xsl:call-template name="telephone-number">
                <xsl:with-param name="telephone-number" select="./work-telephone"/>
              </xsl:call-template>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- output telephone number -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template name="telephone-number">
    <xsl:param name="telephone-number"/>
    <xsl:variable name="telephone-number-nodeset" select="exsl:node-set($telephone-number)"/>
    <fo:block>
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
    </fo:block>
  </xsl:template>

  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <!-- text() template -->
  <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
