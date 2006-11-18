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

  <xsl:template match="print-xml">
    <xml>
      <absolute>
        <xsl:copy-of select="/"/>
      </absolute>
      <relative>
        <xsl:copy-of select="."/>
      </relative>
    </xml>
  </xsl:template>

  <xsl:template name="absolute-and-relative-copy-of">
    <absolute>
      <xsl:copy-of select="/"/>
    </absolute>
    <relative>
      <xsl:copy-of select="."/>
    </relative>
  </xsl:template>

  <xsl:template match="nested">
    <nestedxml>
      <absolute>
        <xsl:copy-of select="/"/>
      </absolute>
      <relative>
        <xsl:copy-of select="."/>
      </relative>
    </nestedxml>
  </xsl:template>

  <xsl:template name="display-attr-of-elem">
    <attr>
      <xsl:value-of select="e/@attr"/>
    </attr>
  </xsl:template>

  <xsl:template name="display-attr">
    <attr>
      <xsl:value-of select="@attr"/>
    </attr>
  </xsl:template>
  
</xsl:stylesheet>
