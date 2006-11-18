<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  $Id: stylesheet_param_tests.xsl,v 1.1.2.1 2006/09/09 21:11:41 jacekrad Exp $
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Purpose: XSLT stylesheet to test UTF-X stylesheet parameters
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

  <xsl:param name="stylesheet-param3" select="'OUTDATED'"/>
  
  <xsl:template match="print-param1">
    <stylesheet-param1><xsl:value-of select="$stylesheet-param1"/></stylesheet-param1>
  </xsl:template>
    
  <xsl:template match="print-param3">
    <stylesheet-param1><xsl:value-of select="$stylesheet-param1"/></stylesheet-param1>
    <stylesheet-param2><xsl:value-of select="$stylesheet-param2"/></stylesheet-param2>
    <stylesheet-param3><xsl:value-of select="$stylesheet-param3"/></stylesheet-param3>
  </xsl:template>
  
  <xsl:template match="copy-param1">
    <xsl:copy-of select="$stylesheet-param1"/>    
  </xsl:template>
  
</xsl:stylesheet>