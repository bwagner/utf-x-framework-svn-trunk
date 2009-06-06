<?xml version="1.0" encoding="UTF-8"?>
<!--
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	$Id: devguide.xml 210 2006-12-11 09:25:54Z jacekrad $
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	Integration tests for SimpleTemplateEngine
	
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="displayParam">
		<xsl:param name="a"/>
		
		<a><xsl:value-of select="$a"/></a>
	</xsl:template>
	
</xsl:stylesheet>
