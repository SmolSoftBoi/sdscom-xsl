<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Basic data types style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">

    <!-- CAS no -->
    <xsl:template name="CasNo">
        <xsl:param name="CasNo"/>
        <xsl:value-of select="$CasNo"/>
    </xsl:template>

    <!-- Country code -->
    <xsl:template name="CountryCodeEnum">
        <xsl:param name="CountryCodeEnum"/>
        <xsl:choose>
            <xsl:when test="$CountryCodeEnum = 'GB'">
                <xsl:value-of select="$CountryCodeEnum-GB"/>
            </xsl:when>
            <xsl:otherwise>
                <strong class="text-danger">Error: Country code not implemented.</strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- D-U-N-S no -->
    <xsl:template name="DunsNo">
        <xsl:param name="DunsNo"/>
        <xsl:value-of select="$DunsNo"/>
    </xsl:template>

    <!-- EC no -->
    <xsl:template name="EcNo">
        <xsl:param name="EcNo"/>
        <xsl:value-of select="$EcNo"/>
    </xsl:template>

    <!-- EuPCS -->
    <xsl:template name="EuPCSEnum">
        <xsl:param name="EuPCSEnum"/>
        <xsl:choose>
            <xsl:when test="$EuPCSEnum = 'PC-AIR-7'">
                <xsl:value-of select="$EuPCSEnum-AIR-7"/>
            </xsl:when>
            <xsl:otherwise>
                <strong class="text-danger">Error: EuPCS not implemented.</strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Form -->
    <xsl:template name="FormEnum">
        <xsl:param name="FormEnum"/>
        <xsl:value-of select="$FormEnum"/>
    </xsl:template>

    <!-- Hazard class category -->
    <xsl:template name="HazardClassCategoryEnum">
        <xsl:param name="HazardClassCategoryEnum"/>
        <xsl:value-of select="$HazardClassCategoryEnum"/>
    </xsl:template>

    <!-- Hazard pictogram -->
    <xsl:template name="HazardPictogram">
        <xsl:param name="HazardPictogram"/>
        <figure class="figure">
            <div class="figure-img img-fluid img-ghs img-{lower-case($HazardPictogram/PhraseCode)}"></div>
            <figcaption class="figure-caption">
                <xsl:call-template name="PictogramCodeEnum">
                    <xsl:with-param name="PictogramCodeEnum" select="$HazardPictogram/PhraseCode"/>
                </xsl:call-template>
            </figcaption>
        </figure>
    </xsl:template>

    <!-- Hazard statement -->
    <xsl:template name="HazardStatement">
        <xsl:param name="HazardStatement"/>
        <xsl:call-template name="HazardStatementEnum">
            <xsl:with-param name="HazardStatementEnum" select="$HazardStatement/PhraseCode"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Hazard statement -->
    <xsl:template name="HazardStatement-DescriptionListRow">
        <xsl:param name="HazardStatement"/>
        <dt class="col-4">
            <xsl:call-template name="HazardStatement">
                <xsl:with-param name="HazardStatement" select="$HazardStatement"/>
            </xsl:call-template>
        </dt>
        <dd class="col-8">
            <xsl:value-of select="$HazardStatement/FullText"/>
        </dd>
    </xsl:template>

    <!-- Hazard statement -->
    <xsl:template name="HazardStatementEnum">
        <xsl:param name="HazardStatementEnum"/>
        H<xsl:value-of select="$HazardStatementEnum"/>
    </xsl:template>

    <!-- Merge phrase - Delimiter -->
    <xsl:template name="MergePhrase-Delimiter">
        <xsl:param name="MergePhrase"/>
        <xsl:value-of select="$MergePhrase/Delimiter"/>
    </xsl:template>

    <!-- Merge phrase - Text -->
    <xsl:template name="MergePhrase-Text">
        <xsl:param name="MergePhrase"/>
        <xsl:value-of select="$MergePhrase/MergeText"/>
    </xsl:template>

    <!-- Packing group -->
    <xsl:template name="PackingGroupEnum">
        <xsl:param name="PackingGroupEnum"/>
        <xsl:value-of select="$PackingGroupEnum"/>
    </xsl:template>

    <!-- Phrase -->
    <xsl:template name="Phrase">
        <xsl:param name="Phrase"/>
        <xsl:choose>
            <xsl:when test="$Phrase/NewLine">
                <br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="MergePhrase-Text">
                    <xsl:call-template name="MergePhrase-Text">
                        <xsl:with-param name="MergePhrase" select="$Phrase/MergePhrase"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="replace($Phrase/FullText, '\.\.\.', $MergePhrase-Text)"/>
                <xsl:call-template name="MergePhrase-Delimiter">
                    <xsl:with-param name="MergePhrase" select="$Phrase/MergePhrase"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- PhysChem unit value -->
    <xsl:template name="PhysChemUnitValue">
        <xsl:param name="PhysChemUnitValue"/>
        <xsl:choose>
            <xsl:when test="$PhysChemUnitValue/ReasonForWaiving">
            <strong class="text-danger">Error: PhysChem unit value not implemented.</strong>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="UnitValue">
                    <xsl:with-param name="UnitValue" select="$PhysChemUnitValue/UnitValue"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Pictogram code -->
    <xsl:template name="PictogramCodeEnum">
        <xsl:param name="PictogramCodeEnum"/>
        <xsl:value-of select="$PictogramCodeEnum"/>
    </xsl:template>

    <!-- Precautionary statement -->
    <xsl:template name="PrecautionaryStatement-DescriptionListRow">
        <xsl:param name="PrecautionaryStatement"/>
        <dt class="col-4">
            <xsl:for-each select="$PrecautionaryStatement/PhraseCode">
                <xsl:if test="position() > 1">
                    <xsl:call-template name="MergePhrase-Delimiter">
                        <xsl:with-param name="MergePhrase" select="$PrecautionaryStatement/MergePhrase"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="PrecautionaryStatementEnum">
                    <xsl:with-param name="PrecautionaryStatementEnum" select="."/>
                </xsl:call-template>
            </xsl:for-each>
        </dt>
        <dd class="col-8">
            <xsl:variable name="MergePhrase-Text">
                <xsl:call-template name="MergePhrase-Text">
                    <xsl:with-param name="MergePhrase" select="$PrecautionaryStatement/MergePhrase"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="replace($PrecautionaryStatement/FullText, '\.\.\.', $MergePhrase-Text)"/>
        </dd>
    </xsl:template>

    <!-- Precautionary statement -->
    <xsl:template name="PrecautionaryStatementEnum"><xsl:param name="PrecautionaryStatementEnum"/>P<xsl:value-of select="$PrecautionaryStatementEnum"/></xsl:template>

    <!-- REACH role description -->
    <xsl:template name="ReachRoleDescriptionEnum">
        <xsl:param name="ReachRoleDescriptionEnum"/>
        <xsl:choose>
            <xsl:when test="$ReachRoleDescriptionEnum = 'Only representative'">
                <xsl:value-of select="$ReachRoleDescriptionEnum-OnlyRepresentative"/>
            </xsl:when>
            <xsl:otherwise>
                <strong class="text-danger">Error: Reach role description not implemented.</strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Signal word -->
    <xsl:template name="SignalWord">
        <xsl:param name="SignalWord"/>
        <xsl:call-template name="SignalWordEnum">
            <xsl:with-param name="SignalWordEnum" select="$SignalWord/PhraseCode"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Signal word -->
    <xsl:template name="SignalWordEnum">
        <xsl:param name="SignalWordEnum"/>
        <xsl:choose>
            <xsl:when test="$SignalWordEnum = 'DGR'">
                <xsl:value-of select="$SignalWordEnum-DGR"/>
            </xsl:when>
            <xsl:when test="$SignalWordEnum = 'WNG'">
                <xsl:value-of select="$SignalWordEnum-WNG"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Transport class -->
    <xsl:template name="TransportClassEnum">
        <xsl:param name="TransportClassEnum"/>
        <xsl:value-of select="$TransportClassEnum"/>
    </xsl:template>

    <!-- Unit value -->
    <xsl:template name="UnitValue">
        <xsl:param name="UnitValue"/>
        <xsl:call-template name="Value">
            <xsl:with-param name="Value" select="$UnitValue"/>
        </xsl:call-template>
        <xsl:value-of select="$UnitValue/Unit"/>
    </xsl:template>

    <!-- Value -->
    <xsl:template name="Value">
        <xsl:param name="Value"/>
        <xsl:choose>
            <xsl:when test="$Value/ExactValue">
            <strong class="text-danger">Error: Value not implemented.</strong>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$Value/LowerValue"/>
                <xsl:if test="$Value/LowerValue and $Value/UpperValue"> - </xsl:if>
                <xsl:value-of select="$Value/UpperValue"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>