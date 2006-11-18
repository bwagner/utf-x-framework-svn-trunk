<?xml version="1.0" encoding="UTF-8"?>
<!--
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    $Id$
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Purpose: XSLT stylesheet for rendering HTML version of UTF-X history.xml
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Copyright(C) 2004-2005 University of Southern Queensland.
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License v2 as published
    by the Free Software Foundation (http://www.gnu.org/licenses/gpl.txt)
    
    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:history="http://utf-x.sourceforge.net/xsd/history_1_0/history.xsd">
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- history template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="history:history">
        <html>
            <head>
                <title>UTF-X Project History</title>
                <style type="text/css">
<![CDATA[

body {
    font-family: Arial;
    color: #666666;
    background-color: #FFFFFF;    
}

th {
    font-family: arial;
}

td {
    font-family: arial;   
}

a {
	color:#000000;
	text-decoration:none;
}

a:hover {
	color:#f5a90b; 
	text-decoration:none;
}

.tag {
    font-family:Courier;
}

.release {
    border-top-color:#666666;
    border-top-style:solid;
    border-top-width:1
    font-family: arial;
    padding:5mm;
}

.description {
    font-family: Arial;
    font-size: 10pt;
}

.short-desc {
    font-weight: bold;
}

.long-desc {
    font-style: italic;
    font-size: 8pt;    
}
.issue-type {
    font-style: bold;
    font-size: 8pt;
}   
]]>
                </style>
            </head>
            <body>
                <h1>
                    <img src="http://utf-x.sf.net/new/images/utf-x.gif" />Change History
                </h1>
                <xsl:apply-templates select="history:release"/>
            </body>
        </html>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- release template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="history:release">
        <div class="release">
            <table width="90%" align="center">
                <tbody>
                    <colgroup>
                        <col width="15%"/>
                        <col width="85%"/>
                    </colgroup>
                    <tr>
                        <th align="left">Release date:</th>
                        <td>
                            <xsl:value-of select="history:date"/>
                        </td>
                    </tr>
                    <tr>
                        <th align="left">Release name:</th>
                        <td>
                            <xsl:value-of select="history:name"/>
                        </td>
                    </tr>
                    <tr>
                        <th align="left">CVS tag:</th>
                        <td class="tag">
                            <xsl:value-of select="history:tag"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table width="100%">
                                <tbody>
                                    <colgroup>
                                        <col width="15%"/>
                                        <col width="35%"/>
                                        <col width="10%"/>
                                        <col width="25%"/>
                                    </colgroup>
                                    <tr>
                                        <th>Date</th>
                                        <th>Issue</th>
                                        <th>Type</th>
                                        <th>Comment</th>
                                    </tr>
                                    <xsl:apply-templates select="history:change"/>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- change template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="history:change">
        <tr>
             <td>    
                <xsl:value-of select="./history:date"/>
             </td>
                <xsl:apply-templates select="history:issue"/>
            
            <td>
                <xsl:value-of select="@type"/>
            </td>
            <td class="description">
                <xsl:value-of select="./history:comment"/>
            </td>
        </tr>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- issue template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="history:issue">
        <xsl:variable name="issue-id">
            <xsl:value-of select="."/>
        </xsl:variable>
        <td>
        <div class="description">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>https://utf-x.dev.java.net/issues/show_bug.cgi?id=</xsl:text>
                    <xsl:value-of select="."/>
                </xsl:attribute>
                <xsl:text>[</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>]</xsl:text>
                <xsl:text>&#160;</xsl:text>
            </a>
            <xsl:for-each select="//issue">
                <xsl:if test="./issue_id = $issue-id">
                    <span class="short-desc">
                        <xsl:value-of select="./short_desc"/>
                    </span>
                    <div class="long-desc">
                        <xsl:value-of select="./long_desc/thetext"/>
                    </div>
                </xsl:if>
            </xsl:for-each>
        </div>
        </td>
    </xsl:template>
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- issue_date template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template name="issue_date">        
    <xsl:param name="issue-id"/>
          <xsl:for-each select="//issue">
                <xsl:if test="./issue_id = $issue-id">
                    <div class="issue-type">
                        <xsl:value-of select="substring(./activity[last()]/when ,1,11)"/>
                    </div>
                </xsl:if>
            </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
