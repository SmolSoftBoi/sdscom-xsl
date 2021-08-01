<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">

    <!-- Classification -->
    <xsl:variable name="Classification-ClpHazardClassCategory" select="'Classification according to Regulation (EC) No 1272/2008 [CLP]'"/>

    <!-- Hazard labelling -->
    <xsl:variable name="HazardLabelling-ClpHazardPictogram" select="'Hazard pictograms'"/>
    <xsl:variable name="HazardLabelling-ClpSignalWord" select="'Signal word'"/>
    <xsl:variable name="HazardLabelling-ClpHazardStatement" select="'Hazard statements'"/>
    <xsl:variable name="HazardLabelling-ClpPrecautionaryStatement" select="'Precautionary statements'"/>
</xsl:stylesheet>