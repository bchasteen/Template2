<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo "&#8249;">
<!ENTITY rsaquo "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
<!ENTITY copy   "&#169;">
<!ENTITY rarr	"&#8594;">
]>
<!-- 
Implementations Skeletor v3 - 5/10/2014

HOME PAGE 
A complex page type.

Contributors: Your Name Here
Last Updated: Enter Date Here
-->
<xsl:stylesheet version="3.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:ou="http://omniupdate.com/XSL/Variables" 
	xmlns:fn="http://omniupdate.com/XSL/Functions" 
	xmlns:ouc="http://omniupdate.com/XSL/Variables" 
	xmlns:media="http://search.yahoo.com/mrss/"
	xmlns:functx="http://www.functx.com" 
	exclude-result-prefixes="ou xsl xs fn ouc functx media">
	
	<xsl:import href="template-matches.xsl"/>
	<xsl:import href="ouvariables.xsl"/>
	<xsl:import href="functions.xsl"/>
	<xsl:import href="cas.xsl"/>
	<xsl:import href="functx-functions.xsl"/>
	<xsl:import href="custom-functions.xsl"/>
	<xsl:import href="tag-management.xsl"/>
	<xsl:import href="ougalleries.xsl"/>
	<xsl:import href="../../ldp/forms/xsl/forms.xsl"/>
	<xsl:import href="breadcrumb.xsl"/>
	<xsl:import href="../navigation/nav.xsl"/>
	<xsl:import href="../calendar/calendar.xsl"/>
	
	<!-- System Params - don't edit -->
	<xsl:param name="ou:action"/>
	<!-- Default: for HTML5 use below output declaration -->
	<xsl:output method="html" indent="yes" encoding="UTF-8" include-content-type="no"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/document">
		<!-- CAS protected Pages.  Set by a parameter in _props.pcf  the local .pcf file that you want to protect. -->
		<xsl:if test="ou:hasCas($props-protection) and $ou:action = 'pub'"><xsl:call-template name="cas-protect"><xsl:with-param name="protection" select="$props-protection"/></xsl:call-template></xsl:if>
		<xsl:if test="ou:pcfparam('destination') != ''"><xsl:call-template name="redirect"/></xsl:if>
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE HTML&gt;</xsl:text>
		<html lang="en">
			<head>
				<xsl:copy-of select="ou:includeFile('/_resources/includes/headcode.inc')"/>
				<title>
					<xsl:value-of select="$page-title"/>
					<xsl:call-template name="title"><xsl:with-param name="path" select="$dirname"/></xsl:call-template>
				</title>
				<xsl:copy-of select="ou:includeFile('/_resources/includes/css.inc')"/>
				<xsl:apply-templates select="headcode/node()"/>
				<xsl:call-template name="calendar-headcode"/> <!-- Add Calendar Code -->
				<xsl:call-template name="form-headcode"/> <!-- Add Form Code -->
				<xsl:if test="descendant::gallery"><xsl:apply-templates select="ou:gallery-headcode(ou:pcfparam('gallery-type'))"/></xsl:if>
			</head>
			<body><a class="sr-only sr-only-focusable" href="#maincontent">Skip to main content</a>
				<xsl:apply-templates select="bodycode/node()"/>
				<xsl:if test="ou:hasCas($props-protection)"><xsl:apply-templates select="ou:casMessage($props-protection)"/></xsl:if>
				<xsl:call-template name="quick-links"/>
				<xsl:call-template name="header" />
				<xsl:call-template name="main-nav"/>
				<xsl:call-template name="template-headcode"/>
				<xsl:call-template name="page-content" />
				<xsl:call-template name="breadcrumb-nav"/>
				<xsl:call-template name="footer" />
				<xsl:call-template name="template-footcode"/>
				<xsl:copy-of select="ou:includeFile('/_resources/includes/final-include.inc')"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="template-headcode"/>
	
	
	
	<xsl:template name="quick-links">
		<nav aria-label="Helpful links" aria-labelledby="quicknav-heading" class="top-nav navbar-inverse">
			<div class="container">
				<div id="quick-links" class="row collapse">
					<xsl:copy-of select="ou:includeFile('/_resources/includes/quick_links.inc')"/>
				</div>
				<div class="row quick-links-bar">
					<a id="quicknav-heading" class="accordion-toggle" role="button" data-toggle="collapse" href="#quick-links" aria-expanded="false" aria-controls="quick-links" aria-haspopup="true">UGA Links 
						<span aria-hidden="true" class="glyphicon glyphicon-triangle-bottom"></span>
					</a>
				</div>
			</div>
		</nav>
	</xsl:template>
	
	<xsl:template name="header">
		<header class="banner" role="banner">
			<div class="container">
				<div class="row">
					<div class="col-md-9 site-logo">
						<a href="/"><img src="/_resources/images/logos/uga_logo.png" alt="UGA Logo"/></a>
					</div>
					<div class="col-md-3 col-xs-12 search-menu hidden-xs">
						<ul class="nav nav-pills">
							<li role="presentation"><a href="/contact/" title="">Contact Us</a></li>
							<li role="presentation"><a href="#">Second Link</a></li>
						</ul>
						<div class="custom-search hidden-xs">
							<xsl:copy-of select="ou:includeFile('/_resources/includes/search.inc')"/>
						</div>
					</div>
				</div>
			</div>
		</header>
	</xsl:template>
	
	<xsl:template name="main-nav">
		<xsl:variable name="path" select="'/_resources/includes/_site-nav/'"/>
		<xsl:variable name="prod-path" select="concat(substring($path, 1, (string-length($path) - 1)), '.html')"/>
		<xsl:try>
			<xsl:choose>
				<xsl:when test="not($ou:action = 'pub') and doc-available(concat($domain, $path))">
					<xsl:copy-of select="doc(concat($domain, $path))" />
				</xsl:when>
				<xsl:when test="not($ou:action = 'pub') and doc-available(concat($domain, $prod-path))">
					<xsl:copy-of select="doc(concat($domain, $prod-path))" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:processing-instruction name="php">include($_SERVER["DOCUMENT_ROOT"]. "<xsl:value-of select="$prod-path"/>"); ?</xsl:processing-instruction>
				</xsl:otherwise>
			</xsl:choose>	
			<xsl:catch>
				<xsl:if test="not($ou:action = 'pub')">
					<xsl:value-of select="doc(concat($domain, $path))" disable-output-escaping="yes"/>
					<p><xsl:value-of select="concat('File not available. Please make sure the path ( ' , concat($domain, $path),' ) is correct and the file is published.')" /></p>
				</xsl:if>
			</xsl:catch>
		</xsl:try>
	</xsl:template>
	
	<xsl:template name="footer">
		<footer class="content-info" role="contentinfo">
			<div id="footer" class="container">
				<div class="row">
					<div class="col-md-3 col-sm-6 col-xs-12 footer-left">
						<a href="http://uga.edu" target="_blank"><img src="/_resources/images/template/uga_logo_V-CW.png" alt="logo" /></a>
						<xsl:call-template name="copyright"/>
						<a href="http://uga.edu/" target="_blank">University of Georgia</a>
					</div>
					<xsl:copy-of select="ou:includeFile('/_resources/includes/footer.inc')"/>
					<div id="de"><ouc:ob /></div>		
				</div>
			</div>
		</footer>
		<xsl:copy-of select="ou:includeFile('/_resources/includes/footcode.inc')" />
	</xsl:template>
	
	<xsl:template name="template-footcode">
		<xsl:apply-templates select="footcode/node()"/>
		<xsl:call-template name="form-footcode"/><!-- Add Form Code -->
		<xsl:if test="descendant::gallery"><xsl:apply-templates select="ou:gallery-footcode(ou:pcfparam('gallery-type'))"/></xsl:if>
		<xsl:call-template name="calendar-footcode"/>
	</xsl:template>
	
	<xsl:template name="copyright">
		<br/><xsl:text>&copy; </xsl:text>
		<xsl:if test="$ou:action = 'edt'"><xsl:value-of select="year-from-date(current-date())"/></xsl:if>
		<xsl:copy-of select="ou:ssi('/_resources/php/copyright.php')" />
		<xsl:text> </xsl:text>
	</xsl:template>
	
	<xsl:template name="redirect">
		<xsl:processing-instruction name="php">header("HTTP/1.1 301 Moved Permanently");
			header("Location: <xsl:value-of select="ou:pcfparam('destination')"/>"); 
		?</xsl:processing-instruction>
	</xsl:template>
</xsl:stylesheet>