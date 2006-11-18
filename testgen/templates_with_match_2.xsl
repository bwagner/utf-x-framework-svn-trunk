<?xml version="1.0" encoding="UTF-8"?>
<!--
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    $Id: templates_with_match_2.xsl,v 1.1.2.1 2006/08/19 07:27:47 lachdrache Exp $
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Purpose: XSLT stylesheet to test and demonstrate TestGenerator
    
    Stylesheet is based on ../src/java/utfx/testgen/test/source_expected_builder_test.xsl
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
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="doc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="element">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="another-element">
        <result-element>
            <xsl:apply-templates/>
        </result-element>            
    </xsl:template>
    <xsl:template match="something-else">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="something-else-still">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="text">
        <result-text>
            <xsl:apply-templates/>
        </result-text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>