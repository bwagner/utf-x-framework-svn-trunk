<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $Id$
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Purpose: XSLT stylesheet to test absolute XPath expressions
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- this template should never match when a test is executed against this stylesheet
       because the root matcher in UTF-X wrapper document must match -->
  <xsl:template match="/">
    <i-am-the-stylesheet-under-test>
      <root-matcher/>
    </i-am-the-stylesheet-under-test>
  </xsl:template>

  <!-- this template should never match when a test is executed against this stylesheet
    because the root matcher in UTF-X wrapper document must match -->
  <xsl:template match="utfx-wrapper">
    <i-am-the-stylesheet-under-test>
      <utfx-wrapper-matcher/>
    </i-am-the-stylesheet-under-test>
  </xsl:template>

  <xsl:template match="tree">
    <el name="tree"/>  
  </xsl:template>
  
</xsl:stylesheet>
