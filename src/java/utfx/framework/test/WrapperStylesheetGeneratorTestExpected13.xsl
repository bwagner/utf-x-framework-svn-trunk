<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $Id: WrapperStylesheetGeneratorTestExpected13.xsl,v 1.1.2.1 2006/08/22 14:57:03 lachdrache Exp $
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:utfx="http://utfx.org/test-definition" xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl" version="1.0">
  <xsl:import href="file:/tests/stylesheetUnderTest.xsl"/>
  <xsl:output method="xml" omit-xml-declaration="yes"/>
  <xsl:template match="/">
    <utfx-wrapper>
      <xsl:variable name="utfx-wrapper-removed">
        <xsl:copy-of select="/utfx-wrapper/child::node()"/>
      </xsl:variable>
      <xsl:apply-templates select="exsl:node-set($utfx-wrapper-removed)/tree/trunk/branch"/>
    </utfx-wrapper>
  </xsl:template>
</xsl:stylesheet>
