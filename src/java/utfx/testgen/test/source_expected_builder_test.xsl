<?xml version="1.0" encoding="UTF-8"?>
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