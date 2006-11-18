<?xml version="1.0" encoding="UTF-8"?>
<!--
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	$Id$
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Purpose: Used by WrapperStylesheetGenerator for generating wrapper stylesheet
			 for executing test case
			 
	Tricky stuff is done here to support absolute XPath expression in the
	stylesheet under test (see issue #42)
	
	Not adding the utfx-wrapper to xml input source would be the obvious solution
	for supporting absolute XPath expressions in the stylesheet under test.
	But that can"t be done because
		1) UTF-X supports source and expected fragments with no root element.
		2) UTF-X supports text nodes only in source and expected
	I.e. adding the utfx-wrapper element is essential.
	
	Therefore the utfx-wrapper element has to be removed from the XML source
	and then be passed to the stylesheet under test.
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utfx="http://utfx.org/test-definition" version="1.0" xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">
	<xsl:import href="name of the stylesheet being tested"/>
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<utfx-wrapper>
			<xsl:variable name="utfx-wrapper-removed">
				<xsl:copy-of select="/utfx-wrapper/child::node()"/>
			</xsl:variable>
		</utfx-wrapper>
	</xsl:template>
</xsl:stylesheet>
