<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $Id: WrapperStylesheetGeneratorTestExpected7.xsl,v 1.1.2.1 2006/08/22 14:57:06 lachdrache Exp $
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Purpose: Expected XML file for WrapperStylesheetGeneratorTest
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Copyright(C) 2006 UTF-X Developers.
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License v2 as published
  by the Free Software Foundation (http://www.gnu.org/licenses/gpl.txt)
  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  General Public License for more details.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet version="1.0" xmlns:utfx="http://utfx.org/test-definition"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl">
  <xsl:import href="file:/tests/stylesheetUnderTest.xsl"/>
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:param name="stylesheet-param1">:-)</xsl:param>
  <xsl:param name="stylesheet-param2" select="2"/>
  <xsl:param name="stylesheet-param3"/>
  <xsl:template match="/">
    <utfx-wrapper>
      <xsl:variable name="utfx-wrapper-removed">
        <xsl:copy-of select="/utfx-wrapper/child::node()"/>
      </xsl:variable>
      <xsl:apply-templates select="exsl:node-set($utfx-wrapper-removed)/child::node()"/>
    </utfx-wrapper>
  </xsl:template>
</xsl:stylesheet>
