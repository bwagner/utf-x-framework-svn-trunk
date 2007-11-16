<?xml version="1.0" encoding="UTF-8"?>
<!--
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    $Id: named_template_param_tests_test.xml 67 2006-11-18 00:40:44Z jacekrad $
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Purpose: Stylesheet under test for test/external_files_tests_test.xml 
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Copyright(C) 2007 UTF-X Developers.
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
    version="1.0">
    
    <xsl:template match="file">
        <xsl:copy-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
