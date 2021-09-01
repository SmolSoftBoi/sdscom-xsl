<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Complex types style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">

    <!-- Classifications - Table -->
    <xsl:template name="Classifications-Table">
        <xsl:param name="Classifications"/>
        <xsl:call-template name="Classification-Table">
            <xsl:with-param name="Classification" select="$Classifications/ClpClassification"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Classification - Table -->
    <xsl:template name="Classification-Table">
        <xsl:param name="Classification"/>
        <table class="table table-bordered table-hover table-sm">
            <thead>
                <tr>
                    <th scope="col">
                        <xsl:value-of select="$Classification-ClpHazardClassCategory"/>
                    </th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="$Classification/ClpHazardClassification">
                    <tr>
                        <td scope="row"><xsl:call-template name="HazardClassCategoryEnum">
                            <xsl:with-param name="HazardClassCategoryEnum" select="ClpHazardClassCategory"/>
                        </xsl:call-template>, <xsl:for-each select="ClpHazardStatement">
                            <xsl:call-template name="HazardStatement">
                                <xsl:with-param name="HazardStatement" select="."/>
                            </xsl:call-template>
                        </xsl:for-each></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>

    <!-- Classification - Cells -->
    <xsl:template name="Classification-Cells">
        <xsl:param name="Classification"/>
        <td scope="row">
            <xsl:for-each select="$Classification/ClpHazardClassification">
                <xsl:if test="position() > 1">
                    <br/>
                </xsl:if>
                <xsl:call-template name="HazardClassCategoryEnum">
                    <xsl:with-param name="HazardClassCategoryEnum" select="ClpHazardClassCategory"/>
                </xsl:call-template>
                <xsl:if test="ClpHazardClassCategory and ClpHazardStatement">, </xsl:if>
                <xsl:for-each select="ClpHazardStatement">
                    <xsl:call-template name="HazardStatement">
                        <xsl:with-param name="HazardStatement" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:for-each>
        </td>
    </xsl:template>

    <!-- Hazard labellings -->
    <xsl:template name="HazardLabellings">
        <xsl:param name="HazardLabellings"/>
        <xsl:call-template name="HazardLabelling">
            <xsl:with-param name="HazardLabelling" select="$HazardLabellings/ClpLabellingInfo"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Hazard labelling -->
    <xsl:template name="HazardLabelling">
        <xsl:param name="HazardLabelling"/>

        <xsl:if test="$HazardLabelling/ClpHazardPictogram">
            <h4>
                <xsl:value-of select="$HazardLabelling-ClpHazardPictogram"/>
            </h4>
            <xsl:for-each select="$HazardLabelling/ClpHazardPictogram">
                <xsl:call-template name="HazardPictogram">
                    <xsl:with-param name="HazardPictogram" select="."/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:if>

        <xsl:if test="$HazardLabelling/ClpSignalWord">
            <h4>
                <xsl:value-of select="$HazardLabelling-ClpSignalWord"/>
            </h4>
            <xsl:call-template name="SignalWord">
                <xsl:with-param name="SignalWord" select="$HazardLabelling/ClpSignalWord"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:if test="$HazardLabelling/ClpHazardStatement">
            <h4>
                <xsl:value-of select="$HazardLabelling-ClpHazardStatement"/>
            </h4>
            <dl class="row">
                <xsl:for-each select="$HazardLabelling/ClpHazardStatement">
                    <xsl:call-template name="HazardStatement-DescriptionListRow">
                        <xsl:with-param name="HazardStatement" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
            </dl>
        </xsl:if>

        <xsl:if test="$HazardLabelling/ClpPrecautionaryStatement">
            <h4>
                <xsl:value-of select="$HazardLabelling-ClpPrecautionaryStatement"/>
            </h4>
            <dl class="row">
                <xsl:for-each select="$HazardLabelling/ClpPrecautionaryStatement">
                    <xsl:call-template name="PrecautionaryStatement-DescriptionListRow">
                        <xsl:with-param name="PrecautionaryStatement" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
            </dl>
        </xsl:if>
    </xsl:template>

    <!-- Substace - Cells -->
    <xsl:template name="Substance-Cells">
        <xsl:param name="Substance"/>
        <td scope="row">
            <xsl:call-template name="SubstanceName">
                <xsl:with-param name="SubstanceName" select="$Substance/SubstanceName"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="CasNo">
                <xsl:with-param name="CasNo" select="$Substance/CasNo"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="EcNo">
                <xsl:with-param name="EcNo" select="$Substance/EcNo"/>
            </xsl:call-template>
        </td>
    </xsl:template>

    <!-- Substance name -->
    <xsl:template name="SubstanceName">
        <xsl:param name="SubstanceName"/>
        <xsl:choose>
            <xsl:when test="$SubstanceName/IupacName">
                <xsl:value-of select="$SubstanceName/IupacName"/>
            </xsl:when>
            <xsl:otherwise>
                <strong class="text-danger">Error: Substance name not implemented.</strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Transport hazard classifications -->
    <xsl:template name="TransportHazardClassifications-Cells">
        <xsl:param name="TransportHazardClassifications"/>
        <td scope="row">
            <xsl:call-template name="TransportClassEnum">
                <xsl:with-param name="TransportClassEnum" select="$TransportHazardClassifications/AdrRid/ClassAdrRid"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="TransportClassEnum">
                <xsl:with-param name="TransportClassEnum" select="$TransportHazardClassifications/Imdg/ClassImdg"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="TransportClassEnum">
                <xsl:with-param name="TransportClassEnum" select="$TransportHazardClassifications/IcaoIata/ClassIcaoIata"/>
            </xsl:call-template>
        </td>
    </xsl:template>

    <!-- Transport packing groups  -->
    <xsl:template name="TransportPackingGroups-Cells">
        <xsl:param name="TransportPackingGroups"/>
        <td scope="row">
            <xsl:call-template name="PackingGroupEnum">
                <xsl:with-param name="PackingGroupEnum" select="$TransportPackingGroups/PackingGroupAdrRid"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="PackingGroupEnum">
                <xsl:with-param name="PackingGroupEnum" select="$TransportPackingGroups/PackingGroupImdg"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="PackingGroupEnum">
                <xsl:with-param name="PackingGroupEnum" select="$TransportPackingGroups/PackingGroupIcaoIata"/>
            </xsl:call-template>
        </td>
    </xsl:template>

    <!-- Transport proper shipping names -->
    <xsl:template name="TransportProperShippingNames-Cells">
        <xsl:param name="TransportProperShippingNames"/>
        <td scope="row">
            <xsl:call-template name="Phrase">
                <xsl:with-param name="Phrase" select="$TransportProperShippingNames/AdrRid/ProperShippingNameNationalAdrRid"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="Phrase">
                <xsl:with-param name="Phrase" select="$TransportProperShippingNames/Imdg/ProperShippingNameEnglishImdg"/>
            </xsl:call-template>
        </td>
        <td scope="row">
            <xsl:call-template name="Phrase">
                <xsl:with-param name="Phrase" select="$TransportProperShippingNames/Icao/ProperShippingNameEnglishIcao"/>
            </xsl:call-template>
        </td>
    </xsl:template>

    <!-- Transport UN numbers -->
    <xsl:template name="TransportUnNumbers-Cells">
        <xsl:param name="TransportUnNumbers"/>
        <td scope="row">
            <xsl:value-of select="$TransportUnNumbers/UnNoAdrRid"/>
        </td>
        <td scope="row">
            <xsl:value-of select="$TransportUnNumbers/UnNoImdg"/>
        </td>
        <td scope="row">
            <xsl:value-of select="$TransportUnNumbers/UnNoIcao"/>
        </td>
    </xsl:template>

</xsl:stylesheet>