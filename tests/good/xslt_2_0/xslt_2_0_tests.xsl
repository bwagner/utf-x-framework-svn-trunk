<?xml version="1.0" encoding="UTF-8"?>
<!--
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    $Id$
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Purpose: XSLT 2.0 stylesheet to test UTF-X XSLT 2.0
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Copyright(C) 2006 UTF-X Developers.
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License v2 as published
    by the Free Software Foundation (http://www.gnu.org/licenses/gpl.txt)
    
    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="/">
        <xsl:apply-templates/>
        <xsl:call-template name="xpath-on-result-tree-fragment"/>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template name="xpath-on-result-tree-fragment">
        <xsl:variable name="tree">
            <tree>
                <branch id="4">
                    <leaf>1</leaf>
                    <leaf>2</leaf>
                    <leaf>3</leaf>
                </branch>
                <branch id="3">
                    <leaf>11</leaf>
                    <leaf>22</leaf>
                    <leaf>33</leaf>
                </branch>
            </tree>
        </xsl:variable>
        <xsl:call-template name="print-tree">
            <xsl:with-param name="tree-summary" select="$tree"/>
        </xsl:call-template>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template name="print-tree">
        <xsl:param name="tree-summary"/>
        <tree-summary>
            <xsl:for-each select="$tree-summary//branch">
                <xsl:sort select="@id" data-type="number"/>
                <branch>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <leaf-sum>
                        <xsl:value-of select="sum(.//leaf)"/>
                    </leaf-sum>
                </branch>
            </xsl:for-each>
        </tree-summary>
    </xsl:template>
</xsl:stylesheet>
