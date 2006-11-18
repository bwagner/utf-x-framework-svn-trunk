<?xml version="1.0" encoding="UTF-8"?>
<!--
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    $Id$
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Purpose: this stylesheet renders output produce by the XMLResultPrinter
        
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Copyright(C) 2006 UTF-X Development Team.
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License v2 as published
    by the Free Software Foundation (http://www.gnu.org/licenses/gpl.txt)
    
    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.
    
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- root element template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="regression-test">
        <html>
            <head>
                <title>UTF-X Test Results</title>
                <style type="text/css"><![CDATA[
/* styles used in test summary */
.suite-name {
  color: #d71be8;
  font-family: Courier;
}
.test-name {
  color: cyan;
  font-family: Courier;
}
.failure {
  font-family: Courier;
  color: red;
}
.error {
  font-family: Courier;
  color: yellow;
}
.ok {
  font-family:Courier;
  color:#44f733;
}
/* these are the styles used when displaying complete test run */
.tr-suite-name {
  color: #d71be8;
  font-family: Courier;
  font-size: 8pt;
}
.tr-test-name {
  color: cyan;
  font-family: Courier;
  font-size: 8pt;
}
.tr-failure {
  font-family: Courier;
  color: red;
  font-size: 8pt;  
}
.tr-error {
  font-family: Courier;
  color: yellow;
  font-size: 8pt;  
}
.tr-ok {
  font-family:Courier;
  color:#44f733;
  font-size: 8pt;  
}

.same-actual {
    color: #44f733;
    font-family: Courier;
}
.same-expected {
    color: yellow;
    font-family: Courier;
}
.diff {
    color: red;
    font-family: Courier;
}
.test-failure {
    padding:2mm;
    border-style:solid;
    border-color:red;
    border-width:1pt;
}
.test-error {
    padding:2mm;
    border-style:solid;
    border-color:yellow;
    border-width:1pt;
}
body {
    font-family: Courier;
    background-color:black;
    color:white;
}
]]>
</style>
            </head>
            <body>
                <div style="font-size:14pt; text-align:center;">UTF-X Test Run
                    Results</div>
                <div style="font-size:12pt; text-align:center;">
                    <xsl:value-of select="//date"/>
                </div>
                <xsl:choose>
                    <xsl:when test="//test-dir != ''">
                        <div style="font-size:12pt; text-align:center;">Test
                            dir: <span style="font-family:Courier;">
                                <xsl:value-of select="//test-dir"/>
                            </span></div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div style="font-size:12pt; text-align:center;">Test
                            file: <span style="font-family:Courier;">
                                <xsl:value-of select="//test-file"/>
                            </span></div>
                    </xsl:otherwise>
                </xsl:choose>

                <div>
                    <xsl:call-template name="test-summary">
                        <xsl:with-param name="summary" select="test-summary"/>
                    </xsl:call-template>
                    <p>Test run details:</p>
                    <div class="test-run-details">
                        <xsl:apply-templates select="./test-suite"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- test suite template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="test-suite">
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td>&#160;</td>
                    <td>
                        <span class="tr-suite-name">Suite '<xsl:value-of
                                select="./suite-name"/>' has <xsl:value-of
                                select="./test-count"/> tests/suites</span>
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                    <td>
                        <xsl:apply-templates/>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- test template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="test">
        <table border="0" cellpadding="0" cellspacing="0">
            <tbody>
                <tr>
                    <td>&#160;</td>
                    <td>[<span class="test-name">
                            <xsl:value-of select="./@count"/>
                        </span>]</td>
                    <td>
                        <span class="tr-suite-name">
                            <xsl:value-of select="../suite-name"/>.</span>
                        <span class="tr-test-name">
                            <xsl:value-of select="./test-name"/>
                        </span>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="count(error) != 0">
                                <span class="tr-error">[<xsl:value-of
                                        select="./error"/>]</span>
                            </xsl:when>
                            <xsl:when test="count(failure) != 0">
                                <span class="tr-failure">[<xsl:value-of
                                        select="./failure"/>]</span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span class="tr-ok">[OK]</span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- test summary template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template name="test-summary">
        <xsl:param name="summary"/>
        <xsl:variable name="errors" select="$summary//error-count"/>
        <xsl:variable name="failures" select="$summary//failure-count"/>
        <xsl:variable name="run-count" select="$summary//run-count"/>
        
        <div>
            <span style="color:cyan;">Time: </span>
            <span><xsl:value-of select="$summary//run-time"/> ms</span>
        </div>
        <div>
            <xsl:choose>
                <xsl:when
                    test="$errors = 0 and $failures = 0">
                    <span style="color:#44f733">OK (<xsl:value-of
                            select="$run-count"/> tests)</span>
                </xsl:when>
                <xsl:otherwise>
                    <span>
                        <xsl:text>Test run: </xsl:text>
                        <xsl:value-of select="$run-count"/>
                    </span>
                    <xsl:if test="$failures != 0">
                        <xsl:text>, </xsl:text>
                        <span class="failure">Failures: <xsl:value-of
                            select="$failures"/></span>
                    </xsl:if>
                    <xsl:if test="$errors != 0">
                        <xsl:text>, </xsl:text>
                        <span class="error">Errors: <xsl:value-of
                            select="$errors"/></span>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <p/>
        <xsl:if test="$failures != 0">
            <div class="failure">There were <xsl:value-of
                    select="$failures"/>
                failures.</div>
            <xsl:apply-templates select="$summary//test-failure"/>
            <p/>
        </xsl:if>

        <xsl:if test="$errors != 0">
            <div class="error"> There were <xsl:value-of
                    select="$errors"/>
                errors.</div>
            <xsl:apply-templates select="$summary//test-error"/>
            <p/>
        </xsl:if>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- test-failure template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="test-failure">
        <div class="test-failure">
            <table>
                <tbody>
                    <tr>
                        <td class="failure">[<xsl:value-of select="@count"/>]</td>
                        <td class="test-name">
                            <xsl:value-of select="./test-name"/>
                        </td>
                        <td class="failure">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="./message"/>
                            <xsl:text>]</xsl:text>
                        </td>
                    </tr>
                </tbody>
            </table>
            <xsl:apply-templates select="string-comparison-failure"/>
        </div>
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- render string comparison failure highlighting the point where actual and
        expected differ -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="string-comparison-failure">
        <p>Actual:</p>
        <span class="same-actual">
            <xsl:value-of select=".//same-content"/>
        </span>
        <span class="diff">
            <xsl:value-of select=".//diff-actual"/>
        </span>
        <p>Expected:</p>
        <span class="same-expected">
            <xsl:value-of select=".//same-content"/>
        </span>
        <span class="diff">
            <xsl:value-of select=".//diff-expected"/>
        </span>        
    </xsl:template>

    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <!-- test-error template -->
    <!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
    <xsl:template match="test-error">
        <div class="test-error">
            <table>
                <tbody>
                    <tr>
                        <td class="error">[<xsl:value-of select="@count"/>]</td>
                        <td class="test-name">
                            <xsl:value-of select="./test-name"/>
                        </td>
                        <td class="error">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="./message"/>
                            <xsl:text>]</xsl:text>
                        </td>
                    </tr>
                </tbody>
            </table>
            <code>
                <pre>
        <xsl:value-of select="stack-trace"/>
        </pre>
            </code>
        </div>
    </xsl:template>

    <xsl:template match="text()">
        <!-- ignore -->
    </xsl:template>
</xsl:stylesheet>
