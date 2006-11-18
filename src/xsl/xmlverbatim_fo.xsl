<?xml version="1.0" encoding="ISO-8859-1"?>

<!--
   XML to XSL:FO Verbatim Formatter with Syntax Highlighting
   Version 1.0
   LGPL (c) Oliver Becker, 2002-08-22
   obecker@informatik.hu-berlin.de
   Contributors: Doug Dicks, added auto-indent (parameter indent-elements)
                 for pretty-print
                 
   XSL:FO port by Jacek Radajewski 30 July 2006
   output valided with RenderX RelaxNG Schema: http://www.renderx.com/tools/validators.html
   and with the W3C Schema shipped with oXygen: http://www.oxygenxml.com
   rendition tested with FOP 0.20.5
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"                
                xmlns:verb="http://informatik.hu-berlin.de/xmlverbatim"
                exclude-result-prefixes="verb">

   <xsl:output method="xml" omit-xml-declaration="yes" indent="no"/>

   <xsl:param name="indent-elements" select="false()" />
   
   <xsl:attribute-set name="xmlverb-default">
      <xsl:attribute name="color">#334455</xsl:attribute>
   </xsl:attribute-set>
   
   <xsl:attribute-set name="xmlverb-element-nsprefix">
      <xsl:attribute name="color">#666600</xsl:attribute>
   </xsl:attribute-set>
   
   <xsl:attribute-set name="xmlverb-element-name">
      <xsl:attribute name="color">#990000</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-ns-name">
      <xsl:attribute name="color">#666600</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-attr-name">
      <xsl:attribute name="color">#660000</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-attr-content">
      <xsl:attribute name="color">#000099</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-ns-uri">
      <xsl:attribute name="color">#330099</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-text">
      <xsl:attribute name="color">#000000</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>      
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-comment">
      <xsl:attribute name="color">#006600</xsl:attribute>
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-pi-name">
      <xsl:attribute name="color">#006600</xsl:attribute>
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="xmlverb-pi-content">
      <xsl:attribute name="color">#006666</xsl:attribute>
      <xsl:attribute name="font-style">italic</xsl:attribute>
   </xsl:attribute-set>

   <xsl:template match="/">
      <xsl:apply-templates select="." mode="xmlverb" />
   </xsl:template>

   <!-- root -->
   <xsl:template match="/" mode="xmlverb">
      <xsl:text>&#xA;</xsl:text>
      <xsl:comment>
         <xsl:text> converted by xmlverbatim_fo.xsl 1.0, (c) O. Becker, J. Radajewski </xsl:text>
      </xsl:comment>
      <xsl:text>&#xA;</xsl:text>
      <fo:block xsl:use-attribute-sets="xmlverb-default">
         <xsl:apply-templates mode="xmlverb">
            <xsl:with-param name="indent-elements" select="$indent-elements" />
         </xsl:apply-templates>
      </fo:block>
      <xsl:text>&#xA;</xsl:text>
   </xsl:template>

   <!-- wrapper -->
   <xsl:template match="verb:wrapper">
      <xsl:apply-templates mode="xmlverb">
         <xsl:with-param name="indent-elements" select="$indent-elements" />
      </xsl:apply-templates>
   </xsl:template>

   <xsl:template match="verb:wrapper" mode="xmlverb">
      <xsl:apply-templates mode="xmlverb">
         <xsl:with-param name="indent-elements" select="$indent-elements" />
      </xsl:apply-templates>
   </xsl:template>

   <!-- element nodes -->
   <xsl:template match="*" mode="xmlverb">
      <xsl:param name="indent-elements" select="false()" />
      <xsl:param name="indent" select="''" />
      <xsl:param name="indent-increment" select="'&#xA0;&#xA0;&#xA0;'" />
      <xsl:if test="$indent-elements">
         <fo:block />
         <xsl:value-of select="$indent" />
      </xsl:if>
      <xsl:text>&lt;</xsl:text>
      <xsl:variable name="ns-prefix"
                    select="substring-before(name(),':')" />
      <xsl:if test="$ns-prefix != ''">
         <fo:inline xsl:use-attribute-sets="xmlverb-element-nsprefix">
            <xsl:value-of select="$ns-prefix"/>
         </fo:inline>
         <xsl:text>:</xsl:text>
      </xsl:if>
      <fo:inline xsl:use-attribute-sets="xmlverb-element-name">
         <xsl:value-of select="local-name()"/>
      </fo:inline>
      <xsl:variable name="pns" select="../namespace::*"/>
      <xsl:if test="$pns[name()=''] and not(namespace::*[name()=''])">
         <fo:inline xsl:use-attribute-sets="xmlverb-ns-name">
            <xsl:text> xmlns</xsl:text>
         </fo:inline>
         <xsl:text>=&quot;&quot;</xsl:text>
      </xsl:if>
      <xsl:for-each select="namespace::*">
         <xsl:if test="not($pns[name()=name(current()) and 
                           .=current()])">
            <xsl:call-template name="xmlverb-ns" />
         </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="@*">
         <xsl:call-template name="xmlverb-attrs" />
      </xsl:for-each>
      <xsl:choose>
         <xsl:when test="node()">
            <xsl:text>&gt;</xsl:text>
            <xsl:apply-templates mode="xmlverb">
              <xsl:with-param name="indent-elements"
                              select="$indent-elements"/>
              <xsl:with-param name="indent"
                              select="concat($indent, $indent-increment)"/>
              <xsl:with-param name="indent-increment"
                              select="$indent-increment"/>
            </xsl:apply-templates>
            <xsl:if test="* and $indent-elements">
               <fo:block />
               <xsl:value-of select="$indent" />
            </xsl:if>
            <xsl:text>&lt;/</xsl:text>
            <xsl:if test="$ns-prefix != ''">
               <fo:inline xsl:use-attribute-sets="xmlverb-element-nsprefix">
                  <xsl:value-of select="$ns-prefix"/>
               </fo:inline>
               <xsl:text>:</xsl:text>
            </xsl:if>
            <fo:inline xsl:use-attribute-sets="xmlverb-element-name">
               <xsl:value-of select="local-name()"/>
            </fo:inline>
            <xsl:text>&gt;</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> /&gt;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="not(parent::*)"><fo:block /><xsl:text>&#xA;</xsl:text></xsl:if>
   </xsl:template>

   <!-- attribute nodes -->
   <xsl:template name="xmlverb-attrs">
      <xsl:text> </xsl:text>
      <fo:inline xsl:use-attribute-sets="xmlverb-attr-name">
         <xsl:value-of select="name()"/>
      </fo:inline>
      <xsl:text>=&quot;</xsl:text>
      <fo:inline xsl:use-attribute-sets="xmlverb-attr-content">
         <xsl:call-template name="html-replace-entities">
            <xsl:with-param name="text" select="normalize-space(.)" />
            <xsl:with-param name="attrs" select="true()" />
         </xsl:call-template>
      </fo:inline>
      <xsl:text>&quot;</xsl:text>
   </xsl:template>

   <!-- namespace nodes -->
   <xsl:template name="xmlverb-ns">
      <xsl:if test="name()!='xml'">
         <fo:inline xsl:use-attribute-sets="xmlverb-ns-name">
            <xsl:text> xmlns</xsl:text>
            <xsl:if test="name()!=''">
               <xsl:text>:</xsl:text>
            </xsl:if>
            <xsl:value-of select="name()"/>
         </fo:inline>
         <xsl:text>=&quot;</xsl:text>
         <fo:inline xsl:use-attribute-sets="xmlverb-ns-uri">
            <xsl:value-of select="."/>
         </fo:inline>
         <xsl:text>&quot;</xsl:text>
      </xsl:if>
   </xsl:template>

   <!-- text nodes -->
   <xsl:template match="text()" mode="xmlverb">
      <fo:inline xsl:use-attribute-sets="xmlverb-text">
         <xsl:call-template name="preformatted-output">
            <xsl:with-param name="text">
               <xsl:call-template name="html-replace-entities">
                  <xsl:with-param name="text" select="." />
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
      </fo:inline>
   </xsl:template>

   <!-- comments -->
   <xsl:template match="comment()" mode="xmlverb">
      <xsl:text>&lt;!--</xsl:text>
      <fo:inline xsl:use-attribute-sets="xmlverb-comment">
         <xsl:call-template name="preformatted-output">
            <xsl:with-param name="text" select="." />
         </xsl:call-template>
      </fo:inline>
      <xsl:text>--&gt;</xsl:text>
      <xsl:if test="not(parent::*)"><fo:block /><xsl:text>&#xA;</xsl:text></xsl:if>
   </xsl:template>

   <!-- processing instructions -->
   <xsl:template match="processing-instruction()" mode="xmlverb">
      <xsl:text>&lt;?</xsl:text>
      <fo:inline xsl:use-attribute-sets="xmlverb-pi-name">
         <xsl:value-of select="name()"/>
      </fo:inline>
      <xsl:if test=".!=''">
         <xsl:text> </xsl:text>
         <fo:inline xsl:use-attribute-sets="xmlverb-pi-content">
            <xsl:value-of select="."/>
         </fo:inline>
      </xsl:if>
      <xsl:text>?&gt;</xsl:text>
      <xsl:if test="not(parent::*)"><fo:block /><xsl:text>&#xA;</xsl:text></xsl:if>
   </xsl:template>


   <!-- =========================================================== -->
   <!--                    Procedures / Functions                   -->
   <!-- =========================================================== -->

   <!-- generate entities by replacing &, ", < and > in $text -->
   <xsl:template name="html-replace-entities">
      <xsl:param name="text" />
      <xsl:param name="attrs" />
      <xsl:variable name="tmp">
         <xsl:call-template name="replace-substring">
            <xsl:with-param name="from" select="'&gt;'" />
            <xsl:with-param name="to" select="'&amp;gt;'" />
            <xsl:with-param name="value">
               <xsl:call-template name="replace-substring">
                  <xsl:with-param name="from" select="'&lt;'" />
                  <xsl:with-param name="to" select="'&amp;lt;'" />
                  <xsl:with-param name="value">
                     <xsl:call-template name="replace-substring">
                        <xsl:with-param name="from" 
                                        select="'&amp;'" />
                        <xsl:with-param name="to" 
                                        select="'&amp;amp;'" />
                        <xsl:with-param name="value" 
                                        select="$text" />
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
         <!-- $text is an attribute value -->
         <xsl:when test="$attrs">
            <xsl:call-template name="replace-substring">
               <xsl:with-param name="from" select="'&#xA;'" />
               <xsl:with-param name="to" select="'&amp;#xA;'" />
               <xsl:with-param name="value">
                  <xsl:call-template name="replace-substring">
                     <xsl:with-param name="from" 
                                     select="'&quot;'" />
                     <xsl:with-param name="to" 
                                     select="'&amp;quot;'" />
                     <xsl:with-param name="value" select="$tmp" />
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$tmp" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- replace in $value substring $from with $to -->
   <xsl:template name="replace-substring">
      <xsl:param name="value" />
      <xsl:param name="from" />
      <xsl:param name="to" />
      <xsl:choose>
         <xsl:when test="contains($value,$from)">
            <xsl:value-of select="substring-before($value,$from)" />
            <xsl:value-of select="$to" />
            <xsl:call-template name="replace-substring">
               <xsl:with-param name="value" 
                               select="substring-after($value,$from)" />
               <xsl:with-param name="from" select="$from" />
               <xsl:with-param name="to" select="$to" />
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$value" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- preformatted output: space as &nbsp;, tab as 8 &nbsp;
                             nl as <fo:block/> -->
   <xsl:template name="preformatted-output">
      <xsl:param name="text" />
      <xsl:call-template name="output-nl">
         <xsl:with-param name="text">
            <xsl:call-template name="replace-substring">
               <xsl:with-param name="value"
                               select="translate($text,' ','&#xA0;')" />
               <xsl:with-param name="from" select="'&#9;'" />
               <xsl:with-param name="to" 
                               select="'&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;'" />
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>

   <!-- output nl as <fo:block/> -->
   <xsl:template name="output-nl">
      <xsl:param name="text" />
      <xsl:choose>
         <xsl:when test="contains($text,'&#xA;')">
            <xsl:value-of select="substring-before($text,'&#xA;')" />
            <fo:block />
            <xsl:text>&#xA;</xsl:text>
            <xsl:call-template name="output-nl">
               <xsl:with-param name="text" 
                               select="substring-after($text,'&#xA;')" />
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$text" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
