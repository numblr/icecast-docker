<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:param name="source_pwd"></xsl:param>
  <xsl:param name="hostname"></xsl:param>


  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="icecast/security/changeowner/user/text()">icecast</xsl:template>
  <xsl:template match="icecast/security/changeowner/group/text()">icecast</xsl:template>

  <xsl:template match="icecast/paths/logdir/text()">/icecast/log</xsl:template>
  <xsl:template match="icecast/paths/webroot/text()">/icecast/web</xsl:template>
  <xsl:template match="icecast/paths/adminroot/text()">/icecast/admin</xsl:template>

  <xsl:template match="icecast/authentication/source-password/text()">
    <xsl:choose>
      <xsl:when test="$source_pwd">
        <xsl:value-of select="$source_pwd"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="icecast/hostname/text()">
    <xsl:choose>
      <xsl:when test="$hostname">
        <xsl:value-of select="$hostname"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
