<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="ascii"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="enable">
comments
processing-instructions
</xsl:param>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:for-each select="@*">
                <xsl:copy/>
            </xsl:for-each>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()">
        <xsl:if test="contains($enable, &#34;comments&#34;)">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="processing-instruction()">
        <xsl:if test="contains($enable, &#34;processing-instructions&#34;)">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>