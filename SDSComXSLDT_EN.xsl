<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">

    <!-- Country code -->
    <xsl:variable name="CountryCodeEnum-GB" select="'United Kingdom'"/>

    <!-- EuPCS -->
    <xsl:variable name="EuPCSEnum-AIR-7" select="'Candles'"/>

    <!-- REACH role description -->
    <xsl:variable name="ReachRoleDescriptionEnum-OnlyRepresentative" select="'Only representative'"/>

    <!-- Signal word -->
    <xsl:variable name="SignalWordEnum-DGR" select="'Danger'"/>
    <xsl:variable name="SignalWordEnum-WNG" select="'Warning'"/>
</xsl:stylesheet>