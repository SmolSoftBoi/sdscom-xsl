<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">
    <xsl:include href="SDSComXSLCT.xsl"/>
    <xsl:include href="SDSComXSLDT.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Root node -->
    <xsl:template match="/">
        <html lang="{SDSCom:DatasheetFeed/Datasheet[1]/InformationFromExportingSystem/Language/FreetextLanguageCode}">
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

                <!-- CSS -->
                <link href="assets/css/starter.css" rel="stylesheet"/>
                <style>
                    h2::before,
                    .h2::before {
                        content: "<xsl:value-of select="$Section"/> counter(section) ": ";
                    }
                </style>

                <title>
                    <xsl:value-of select="$Title"/>
                </title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- Root node for data exchange: DatasheetFeed -->
    <xsl:template match="SDSCom:DatasheetFeed">
        <div class="sds container">
            <xsl:for-each select="Datasheet">
                    <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Summary: The complete SDS -->
    <xsl:template match="Datasheet">
        <div class="datasheet">

            <!-- Section 0 (Header informations) -->
            <div class="header sticky-top">
                <h1>
                    <xsl:value-of select="$Header"/>
                    <br/>
                    <small>
                        <xsl:value-of select="$SubHeader"/>
                    </small>
                </h1>
                <xsl:if test="IdentificationSubstPrep/ProductIdentity/TradeName">
                    <div class="row">
                        <div class="col">
                            <dl class="row">
                                <dt class="col-2"><xsl:value-of select="$HeaderTradeName"/>:</dt>
                                <dd class="col-10">
                                    <xsl:value-of select="IdentificationSubstPrep/ProductIdentity/TradeName[1]"/>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </xsl:if>
                <div class="row">
                    <div class="col">
                        <dl class="row">
                            <dt class="col-4"><xsl:value-of select="$HeaderProductNo"/>:</dt> 
                            <dd class="col-8">
                                <xsl:choose>
                                    <xsl:when test="IdentificationSubstPrep/ItemNo">
                                        <xsl:value-of select="IdentificationSubstPrep/ItemNo[1]" separator=", "/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="IdentificationSubstPrep/ProductNo[1]/ProductNoUser[1]"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </dd>
                        </dl>
                    </div>
                    <div class="col">
                        <xsl:if test="IdentificationSubstPrep/DateGeneratedExport">
                            <dl class="row">
                                <dt class="col-4"><xsl:value-of select="$HeaderExportDate"/>:</dt>
                                <dd class="col-8">
                                    <xsl:value-of select="format-date(IdentificationSubstPrep/DateGeneratedExport, '[D01].[M01].[Y0001]')"/>
                                </dd>
                            </dl>
                        </xsl:if>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <dl class="row">
                            <dt class="col-4"><xsl:if test="IdentificationSubstPrep/VersionNo"><xsl:value-of select="$HeaderVersion"/>:</xsl:if></dt>
                            <dd class="col-8">
                                <xsl:if test="IdentificationSubstPrep/VersionNo"><xsl:value-of select="IdentificationSubstPrep/VersionNo"/> / </xsl:if><xsl:value-of select="upper-case(InformationFromExportingSystem/Language/FreetextLanguageCode)"/>
                            </dd>
                        </dl>
                    </div>
                    <div class="col">
                        <xsl:if test="IdentificationSubstPrep/RevisionDate">
                            <dl class="row">
                                <dt class="col-4"><xsl:value-of select="$HeaderRevisionDate"/>:</dt>
                                <dd class="col-8">
                                    <xsl:value-of select="format-date(IdentificationSubstPrep/RevisionDate, '[D01].[M01].[Y0001]')"/>
                                </dd>
                            </dl>
                        </xsl:if>
                    </div>
                </div>
            </div>

            <!-- Section 1 (Identification of the substance/mixture and of the company/undertaking) -->
            <xsl:apply-templates select="IdentificationSubstPrep"/>

            <!-- Section 2 (Hazards identification) -->
            <xsl:apply-templates select="HazardIdentification"/>

            <!-- Section 3 (Composition/information on ingredients) -->
            <xsl:apply-templates select="Composition"/>

            <!-- Section 4 (First aid measures) -->
            <xsl:apply-templates select="FirstAidMeasures"/>

            <!-- Section 5 (Firefighting measures) -->
            <xsl:apply-templates select="FireFightingMeasures"/>

            <!-- Section 6 (Accidental release measures) -->
            <xsl:apply-templates select="AccidentalReleaseMeasures"/>

            <!-- Section 7 (Handling and storage) -->
            <xsl:apply-templates select="HandlingAndStorage"/>

            <!-- Section 8 (Exposure controls / personal protection) -->
            <xsl:apply-templates select="ExposureControlPersonalProtection"/>

            <!-- Section 9 (Physical and chemical properties) -->
            <xsl:apply-templates select="PhysicalChemicalProperties"/>

            <!-- Section 10 (Stability and reactivity) -->
            <xsl:apply-templates select="StabilityReactivity"/>

            <!-- Section 11 (Toxicological information) -->
            <xsl:apply-templates select="ToxicologicalInformation"/>

            <!-- Section 12 (Ecological information) -->
            <xsl:apply-templates select="EcologicalInformation"/>

            <!-- Section 13 (Disposal considerations) -->
            <xsl:apply-templates select="DisposalConsiderations"/>

            <!-- Section 14 (Transport information) -->
            <xsl:apply-templates select="TransportInformation"/>

            <!-- Section 15 (Regulatory information) -->
            <xsl:apply-templates select="RegulatoryInfo"/>

            <!-- Section 16 (Other information) -->
            <xsl:apply-templates select="OtherInformation"/>
        </div>
    </xsl:template>

    <!-- Section 1 -->
    <xsl:template match="IdentificationSubstPrep">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section1"/>
            </h2>
            <ol>
                <!-- Product identifier -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section1.1"/>
                    </h3>
                    <xsl:choose>
                        <xsl:when test="../Composition/Substance">
                            <strong class="text-danger">Error: Section 1.1 not implemented for substances.</strong>
                        </xsl:when>
                        <xsl:when test="../Composition/Component">
                            <dl class="row">
                                <xsl:if test="ProductIdentity/TradeName">
                                    <dt class="col-4">
                                        <h4><xsl:value-of select="$Section1.1-TradeName"/></h4>
                                    </dt>
                                    <dd class="col-8">
                                        <xsl:value-of select="ProductIdentity/TradeName" separator=", "/>
                                    </dd>
                                </xsl:if>
                            </dl>

                            <xsl:if test="ItemNo or ProductNo or ProductIdentity/ProductGtin">
                                <h4>
                                    <xsl:value-of select="$Section1.1-OtherId"/>
                                </h4>
                                <dl class="row">
                                    <xsl:if test="ItemNo">
                                        <dt class="col-4">
                                            <h5><xsl:value-of select="$Section1.1-ItemNo"/></h5>
                                        </dt>
                                        <dd class="col-8">
                                            <xsl:for-each select="ItemNo">
                                                <xsl:if test="position() > 1">
                                                    <br/>
                                                </xsl:if>
                                                <xsl:value-of select="."/>
                                            </xsl:for-each>
                                        </dd>
                                    </xsl:if>

                                    <xsl:if test="ProductNo">
                                        <dt class="col-4">
                                            <h5><xsl:value-of select="$Section1.1-ProductNo"/></h5>
                                        </dt>
                                        <dd class="col-8">
                                            <xsl:for-each select="ProductNo">
                                                <xsl:if test="position() > 1">
                                                    <br/>
                                                </xsl:if>
                                                <xsl:value-of select="."/>
                                            </xsl:for-each>
                                        </dd>
                                    </xsl:if>

                                    <xsl:if test="ProductIdentity/ProductGtin">
                                        <dt class="col-4">
                                            <h5><xsl:value-of select="$Section1.1-ProductGtin"/></h5>
                                        </dt>
                                        <dd class="col-8">
                                            <xsl:for-each select="ProductIdentity/ProductGtin">
                                                <xsl:if test="position() > 1">
                                                    <br/>
                                                </xsl:if>
                                                <xsl:value-of select="."/>
                                            </xsl:for-each>
                                        </dd>
                                    </xsl:if>
                                </dl>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </li>

                <!-- Relevant identified uses of the substance or mixture and uses advised against -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section1.2"/>
                    </h3>
                    <xsl:if test="MainIntendedUse">
                        <dl class="row">
                            <dt class="col-4">
                                <xsl:value-of select="$Section1.2-MainIntendedUse"/>
                            </dt>
                            <dd class="col-8">
                                <xsl:call-template name="EuPCSEnum">
                                    <xsl:with-param name="EuPCSEnum" select="MainIntendedUse"/>
                                </xsl:call-template>
                            </dd>
                        </dl>
                    </xsl:if>

                    <xsl:if test="RelevantIdentifiedUse">
                        <h4>
                            <xsl:value-of select="$Section1.2-RelevantIdentifiedUse"/>
                        </h4>
                        <xsl:for-each select="RelevantIdentifiedUse/ProductFunctionDescription">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>

                    <xsl:if test="UseAdvisedAgainst">
                        <h4>
                            <xsl:value-of select="$Section1.2-UseAdvisedAgainst"/>
                        </h4>
                        <strong class="text-danger">Error: Section 1.2 not implemented for uses advised against.</strong>
                    </xsl:if>
                </li>

                <!-- Details of the supplier of the safety data sheet -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section1.3"/>
                    </h3>
                    <xsl:for-each select="SupplierInformation">
                        <h4>
                            <xsl:choose>
                                <xsl:when test="Role/RoleCode">
                                    <xsl:call-template name="RoleDescriptionEnum">
                                        <xsl:with-param name="RoleDescriptionEnum" select="Role/RoleCode"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <strong class="text-danger">Error: Section 1.3 not implemented for role.</strong>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h4>
                        <dl class="row">
                            <dt class="col-4">
                                <h5>
                                    <xsl:value-of select="$Section1.3-Name"/>
                                </h5>
                            </dt>
                            <dd class="col-8">
                                <xsl:value-of select="Name"/>
                            </dd>

                            <xsl:if test="Address/VisitingAddressLine1 or Address/VisitingAddressLine2 or Address/VisitingAddressLine3 or Address/VisitingAddressCity or Address/VisitingAddressPostCode">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section1.3-VisitingAddress"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <address>
                                        <xsl:for-each select="(Address/VisitingAddressLine1, Address/VisitingAddressLine2, Address/VisitingAddressLine3, Address/VisitingAddressCity)">
                                            <xsl:if test="position() > 1">
                                                <br/>
                                            </xsl:if>
                                            <xsl:value-of select="."/>
                                        </xsl:for-each>
                                        <xsl:if test="(Address/VisitingAddressLine1 or Address/VisitingAddressLine2 or Address/VisitingAddressLine3 or Address/VisitingAddressCity) and Address/VisitingAddressPostCode">, </xsl:if>
                                        <xsl:value-of select="substring-after(Address/VisitingAddressPostCode, '-')"/>
                                        <br/>
                                        <xsl:call-template name="CountryCodeEnum">
                                            <xsl:with-param name="CountryCodeEnum" select="Country"/>
                                        </xsl:call-template>
                                    </address>
                                </dd>
                            </xsl:if>
                            <xsl:if test="Address/PostAddressLine1 or Address/PostAddressLine2 or Address/PostAddressLine3 or Address/PostCity or Address/PostCode">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section1.3-PostAddress"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <address>
                                        <xsl:for-each select="(Address/PostAddressLine1, Address/PostAddressLine2, Address/PostAddressLine3, Address/PostCity)">
                                            <xsl:if test="position() > 1">
                                                <br/>
                                            </xsl:if>
                                            <xsl:value-of select="."/>
                                        </xsl:for-each>
                                        <xsl:if test="(Address/PostAddressLine1 or Address/PostAddressLine2 or Address/PostAddressLine3 or Address/PostCity) and Address/PostCode">, </xsl:if>
                                        <xsl:value-of select="substring-after(Address/PostCode, '-')"/>
                                        <br/>
                                        <xsl:call-template name="CountryCodeEnum">
                                            <xsl:with-param name="CountryCodeEnum" select="Country"/>
                                        </xsl:call-template>
                                    </address>
                                </dd>
                            </xsl:if>

                            <dt class="col-4">
                                <h5>
                                    <xsl:value-of select="$Section1.3-Phone"/>
                                </h5>
                            </dt>
                            <dd class="col-8">
                                <xsl:for-each select="Phone">
                                    <xsl:if test="position() > 1">
                                        <br/>
                                    </xsl:if>
                                    <xsl:value-of select="."/>
                                </xsl:for-each>
                            </dd>

                            <xsl:if test="Email">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section1.3-Email"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <xsl:for-each select="Email">
                                        <xsl:if test="position() > 1">
                                            <br/>
                                        </xsl:if>
                                        <a href="mailto:{.}?subject={$Title}%20{ProductNo}"><xsl:value-of select="."/></a>
                                    </xsl:for-each>
                                </dd>
                            </xsl:if>

                            <xsl:if test="CompanyUrl">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section1.3-CompanyUrl"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <a href="CompanyUrl" target="_blank"><xsl:value-of select="CompanyUrl"/></a>
                                </dd>
                            </xsl:if>

                            <xsl:for-each select="CompanyContact">
                                <xsl:if test="Name">
                                    <dt class="col-4">
                                        <h5>
                                            <xsl:value-of select="$Section1.3-CompanyContactName"/>
                                        </h5>
                                    </dt>
                                    <dd class="col-8">
                                        <xsl:value-of select="Name"/>
                                    </dd>
                                </xsl:if>

                                <xsl:if test="Email">
                                    <dt class="col-4">
                                        <h5>
                                            <xsl:value-of select="$Section1.3-CompanyContactEmail"/>
                                        </h5>
                                    </dt>
                                    <dd class="col-8">
                                        <a href="mailto:{Email}?subject={$Title}%20{ProductNo}"><xsl:value-of select="Email"/></a>
                                    </dd>
                                </xsl:if>

                                <xsl:if test="EmailCompetentPerson">
                                    <dt class="col-4">
                                        <h5>
                                            <xsl:value-of select="$Section1.3-CompanyContactEmailCompetentPerson"/>
                                        </h5>
                                    </dt>
                                    <dd class="col-8">
                                        <a href="mailto:{EmailCompetentPerson}?subject={$Title}%20{ProductNo}"><xsl:value-of select="EmailCompetentPerson"/></a>
                                    </dd>
                                </xsl:if>
                            </xsl:for-each>

                            <xsl:if test="Duns">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section1.3-Duns"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <xsl:call-template name="DunsNo">
                                        <xsl:with-param name="DunsNo" select="Duns"/>
                                    </xsl:call-template>
                                </dd>
                            </xsl:if>
                        </dl>
                    </xsl:for-each>
                </li>

                <!-- EMERGENCY TELEPHONE NUMBER -->
                <li>
                    <h3 class="text-uppercase">
                        <xsl:value-of select="$Section1.4"/>
                    </h3>
                    <xsl:if test="EmergencyPhone">
                        <dl class="row">
                            <xsl:for-each select="EmergencyPhone">
                                <dt class="col-4">
                                    <a href="tel:{No}"><xsl:value-of select="No"/></a>
                                </dt>
                                <dd class="col-8">
                                    <xsl:for-each select="EmergencyPhoneDescription">
                                        <xsl:call-template name="Phrase">
                                            <xsl:with-param name="Phrase" select="."/>
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </dd>
                            </xsl:for-each>
                        </dl>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 2 -->
    <xsl:template match="HazardIdentification">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section2"/>
            </h2>
            <ol>
                <!-- Classification of the substance or mixture -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section2.1"/>
                    </h3>
                    <xsl:call-template name="Classifications-Table">
                        <xsl:with-param name="Classifications" select="Classification"/>
                    </xsl:call-template>
                </li>

                <!-- Label elements -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section2.2"/>
                    </h3>
                    <xsl:if test="HazardLabelling">
                        <strong>
                            <xsl:value-of select="$Section2.2-HazardLabelling"/>
                        </strong>
                        <xsl:call-template name="HazardLabellings">
                            <xsl:with-param name="HazardLabellings" select="HazardLabelling"/>
                        </xsl:call-template>
                    </xsl:if>
                </li>

                <!-- Other hazards -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section2.3"/>
                    </h3>
                    <xsl:if test="OtherHazardsInfo">
                        <dl class="row">
                            <xsl:if test="OtherHazardsInfo/PhysicochemicalEffect">
                                <strong class="text-danger">Error: Section 2.3 not implemented for physiochemical effects.</strong>
                            </xsl:if>
                            <xsl:if test="OtherHazardsInfo/HealthEffect">
                                <strong class="text-danger">Error: Section 2.3 not implemented for health effects.</strong>
                            </xsl:if>
                            <xsl:if test="OtherHazardsInfo/EnvironmentalEffect">
                                <strong class="text-danger">Error: Section 2.3 not implemented for environmental effects.</strong>
                            </xsl:if>
                            <xsl:if test="OtherHazardsInfo/OtherHazards">
                                <dt clas="col-4">
                                    <h4>
                                        <xsl:value-of select="$Section2.3-OtherHazards"/>
                                    </h4>
                                </dt>
                                <dd class="col-8">
                                    <xsl:for-each select="OtherHazardsInfo/OtherHazards">
                                        <xsl:call-template name="Phrase">
                                            <xsl:with-param name="Phrase" select="."/>
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </dd>
                            </xsl:if>
                        </dl>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 3 -->
    <xsl:template match="Composition">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section3"/>
            </h2>
            <ol>
                <!-- Substances -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section3.1"/>
                    </h3>
                    <xsl:choose>
                        <xsl:when test="Substance">
                            <strong class="text-danger">Error: Section 3.1 not implemented.</strong>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$Section3-NA"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>

                <!-- Mixtures -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section3.2"/>
                    </h3>
                    <xsl:choose>
                        <xsl:when test="Component">
                            <xsl:if test="ChemicalCharacterization">
                                <h4>
                                    <xsl:value-of select="$Section3.2-ChemicalCharacterization"/>
                                </h4>
                                <xsl:for-each select="ChemicalCharacterization">
                                    <xsl:call-template name="Phrase">
                                        <xsl:with-param name="Phrase" select="."/>
                                    </xsl:call-template>
                                </xsl:for-each>
                            </xsl:if>

                            <h4>
                                <xsl:value-of select="$Section3.2-Component"/>
                            </h4>
                            <table class="table table-bordered table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th scope="col">
                                            <xsl:value-of select="$Section3.2-ComponentSubstanceName"/>
                                        </th>
                                        <th scope="col">
                                            <xsl:value-of select="$Section3.2-ComponentSubstanceCasNo"/>
                                        </th>
                                        <th scope="col">
                                            <xsl:value-of select="$Section3.2-ComponentSubstanceEcNo"/>
                                        </th>
                                        <th scope="col">
                                            <xsl:value-of select="$Section3.2-ComponentConcentration"/>
                                        </th>
                                        <th scope="col">
                                            <xsl:value-of select="$Section3.2-ComponentClassificationClpHazardClassification"/>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="Component">
                                        <tr>
                                            <xsl:apply-templates select="."/>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$Section3-NA"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Component -->
    <xsl:template match="Component">
        <xsl:call-template name="Substance-Cells">
            <xsl:with-param name="Substance" select="Substance"/>
        </xsl:call-template>
        <td scope="row">
            <xsl:call-template name="UnitValue">
                <xsl:with-param name="UnitValue" select="Concentration"/>
            </xsl:call-template>
        </td>
        <xsl:call-template name="Classification-Cells">
            <xsl:with-param name="Classification" select="Classification"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Section 4 -->
    <xsl:template match="FirstAidMeasures">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section4"/>
            </h2>
            <ol>

                <!-- Description of first aid measures -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section4.1"/>
                    </h3>
                    <xsl:if test="DescriptionOfFirstAidMeasures">
                        <xsl:if test="DescriptionOfFirstAidMeasures/FirstAidSkin">
                            <h4>
                                <xsl:value-of select="$Section4.1-FirstAidInhalation"/>
                            </h4>
                            <xsl:for-each select="DescriptionOfFirstAidMeasures/FirstAidInhalation">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="DescriptionOfFirstAidMeasures/FirstAidSkin">
                            <h4>
                                <xsl:value-of select="$Section4.1-FirstAidSkin"/>
                            </h4>
                            <xsl:for-each select="DescriptionOfFirstAidMeasures/FirstAidSkin">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="DescriptionOfFirstAidMeasures/FirstAidEye">
                            <h4>
                                <xsl:value-of select="$Section4.1-FirstAidEye"/>
                            </h4>
                            <xsl:for-each select="DescriptionOfFirstAidMeasures/FirstAidEye">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="DescriptionOfFirstAidMeasures/FirstAidIngestion">
                            <h4>
                                <xsl:value-of select="$Section4.1-FirstAidIngestion"/>
                            </h4>
                            <xsl:for-each select="DescriptionOfFirstAidMeasures/FirstAidIngestion">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:if>
                </li>

                <!-- Most important symptoms and effects, both acute and delayed -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section4.2"/>
                    </h3>
                    <xsl:if test="InformationToHealthProfessionals">
                        <strong class="text-danger">Error: Section 4.2 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Indication of any immediate medical attention and special treatment needed -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section4.3"/>
                    </h3>
                    <xsl:if test="MedicalAttentionAndSpecialTreatmentNeeded/MedicalTreatmentMedicalTreatment">
                        <strong class="text-danger">Error: Section 4.3 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 5 -->
    <xsl:template match="FireFightingMeasures">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section5"/>
            </h2>
            <ol>

                <!-- Extinguishing media -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section5.1"/>
                    </h3>
                    <xsl:if test="ExtinguishingMedia">
                        <xsl:if test="ExtinguishingMedia/MediaToBeUsed">
                            <h4>
                                <xsl:value-of select="$Section5.1-MediaToBeUsed"/>
                            </h4>
                            <xsl:for-each select="ExtinguishingMedia/MediaToBeUsed">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="ExtinguishingMedia/MediaNotBeUsed">
                            <h4>
                                <xsl:value-of select="$Section5.1-MediaNotBeUsed"/>
                            </h4>
                            <xsl:for-each select="ExtinguishingMedia/MediaNotBeUsed">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:if>
                </li>

                <!-- Special hazards arising from the substance or mixture -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section5.2"/>
                    </h3>
                    <xsl:if test="HazardCombustionProd">
                        <h4>
                            <xsl:value-of select="$Section5.2-HazardCombustionProd"/>
                        </h4>
                        <xsl:for-each select="HazardCombustionProd">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </li>

                <!-- Advice for fire-fighters -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section5.3"/>
                    </h3>
                    <xsl:if test="FireFightingPrecautions">
                        <xsl:for-each select="FireFightingPrecautions">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 6 -->
    <xsl:template match="AccidentalReleaseMeasures">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section6"/>
            </h2>
            <ol>
                <li>
                    <!-- Personal precautions, protective equipment and emergency procedures -->
                    <h3>
                        <xsl:value-of select="$Section6.1"/>
                    </h3>
                    <xsl:if test="ForNonEmergencyPersonnel">
                        <h4>
                            <xsl:value-of select="$Section6.1-ForNonEmergencyPersonnel"/>
                        </h4>
                        <xsl:if test="ForNonEmergencyPersonnel/PersonalPrecautions">
                            <h5>Personal precautions</h5>
                            <xsl:for-each select="ForNonEmergencyPersonnel/PersonalPrecautions">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:if>
                </li>

                <!-- Environmental precautions -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section6.2"/>
                    </h3>
                    <xsl:for-each select="EnvironmentalPrecautions">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Methods and material for containment and cleaning up -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section6.3"/>
                    </h3>
                    <xsl:if test="ContainmentAndCleaningUp/Containment">
                        <h4>
                            <xsl:value-of select="$Section6.3-Containment"/>
                        </h4>
                        <xsl:for-each select="ContainmentAndCleaningUp/Containment">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </li>

                <!-- Reference to other sections -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section6.4"/>
                    </h3>
                    <xsl:for-each select="ReferenceToOtherSections">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 7 -->
    <xsl:template match="HandlingAndStorage">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section7"/>
            </h2>
            <ol>
                <!-- Precautions for safe handling -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section7.1"/>
                    </h3>

                    <xsl:if test="SafeHandling/PrecautionaryMeasures">
                        <h4>
                            <xsl:value-of select="$Section7.1-PrecautionaryMeasures"/>
                        </h4>
                    
                        <xsl:if test="SafeHandling/PrecautionaryMeasures/MeasuresToPreventFire">
                            <h5>
                                <xsl:value-of select="$Section7.1-PrecautionaryMeasuresToPreventFire"/>
                            </h5>
                            <xsl:for-each select="SafeHandling/PrecautionaryMeasures/MeasuresToPreventFire">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="SafeHandling/PrecautionaryMeasures/MeasuresToPreventAerosolAndDust">
                            <h5>
                                <xsl:value-of select="$Section7.1-PrecautionaryMeasuresToPreventAerosolAndDust"/>
                            </h5>
                            <xsl:for-each select="SafeHandling/PrecautionaryMeasures/MeasuresToPreventAerosolAndDust">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:if>
                </li>

                <!-- Conditions for safe storage, including any incompatibilities -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section7.2"/>
                    </h3>
                    <xsl:if test="ConditionsForSafeStorage">
                        <xsl:if test="ConditionsForSafeStorage/RequirementsForStorageRoomsAndVessels">
                            <h4>
                                <xsl:value-of select="$Section7.2-RequirementsForStorageRoomsAndVessels"/>
                            </h4>
                            <xsl:for-each select="ConditionsForSafeStorage/RequirementsForStorageRoomsAndVessels">
                                <xsl:call-template name="Phrase">
                                    <xsl:with-param name="Phrase" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:if>
                </li>

                <!-- Specific end uses -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section7.3"/>
                    </h3>
                    <xsl:if test="SpecificEndUses">
                        <strong class="text-danger">Error: Section 7.3 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 8 -->
    <xsl:template match="ExposureControlPersonalProtection">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section8"/>
            </h2>
            <ol>
                <!-- Control parameters -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section8.1"/>
                    </h3>
                    <xsl:if test="ControlParameters">
                        <strong class="text-danger">Error: Section 8.1 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Exposure controls -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section8.2"/>
                    </h3>
                    <xsl:if test="ExposureControlAppropriateMeasures">
                        <strong class="text-danger">Error: Section 8.2 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 9 -->
    <xsl:template match="PhysicalChemicalProperties">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section9"/>
            </h2>
            <ol>
                <!-- Information on basic physical and chemical properties -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section9.1"/>
                    </h3>

                    <xsl:if test="Appearance">
                        <h4>
                            <xsl:value-of select="$Section9.1-Appearance"/>
                        </h4>

                        <dl class="row">
                            <xsl:if test="Appearance/Form">
                                <dt class="col-4">
                                    <h5>
                                        <xsl:value-of select="$Section9.1-AppearanceForm"/>
                                    </h5>
                                </dt>
                                <dd class="col-8">
                                    <xsl:call-template name="FormEnum">
                                        <xsl:with-param name="FormEnum" select="Appearance/Form"/>
                                    </xsl:call-template>
                                </dd>
                            </xsl:if>
                        </dl>
                    </xsl:if>

                    <xsl:if test="SafetyRelevantInformation">
                        <table class="table table-bordered table-hover table-sm">
                            <thead>
                                <tr>
                                    <th scope="col"></th>
                                    <th scope="col">
                                        <xsl:value-of select="$Section9.1-SafetyRelevantInformationValue"/>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:if test="SafetyRelevantInformation/MeltingPointRelated/MeltingPoint or SafetyRelevantInformation/MeltingPointRelated/FreezingPoint">
                                    <tr>
                                        <th scope="row">
                                            <xsl:value-of select="$Section9.1-SafetyRelevantInformationMeltingPoint"/>
                                        </th>
                                        <td scope="row">
                                            <xsl:call-template name="PhysChemUnitValue">
                                                <xsl:with-param name="PhysChemUnitValue" select="SafetyRelevantInformation/MeltingPointRelated/MeltingPoint"/>
                                            </xsl:call-template>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </tbody>
                        </table>
                    </xsl:if>
                </li>

                <!-- Other information -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section9.2"/>
                    </h3>
                    <xsl:if test="PhysicalHazards">
                        <strong class="text-danger">Error: Section 9.2 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 10 -->
    <xsl:template match="StabilityReactivity">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section10"/>
            </h2>
            <ol>
                <!-- Reactivity -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.1"/>
                    </h3>
                    <xsl:for-each select="ReactivityDescription">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Chemical stability -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.2"/>
                    </h3>
                    <xsl:for-each select="StabilityDescription">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Possibility of hazardous reactions -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.3"/>
                    </h3>
                    <xsl:for-each select="HazardousReactions">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Conditions to avoid -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.4"/>
                    </h3>
                    <xsl:for-each select="ConditionsToAvoid">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Incompatible materials -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.5"/>
                    </h3>
                    <xsl:for-each select="MaterialsToAvoid">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Hazardous decomposition products -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section10.6"/>
                    </h3>
                    <xsl:for-each select="HazardousDecompositionProducts">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 11 -->
    <xsl:template match="ToxicologicalInformation">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section11"/>
            </h2>
            <ol>
                <!-- Information on hazard classes as defined in Regulation (EC) No 1272/2008 -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section11.1"/>
                    </h3>
                </li>

                <!-- Information on other hazards -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section11.2"/>
                    </h3>
                    <xsl:if test="OtherInformation">
                        <h4>
                            <xsl:value-of select="$Section11.2-OtherInformation"/>
                        </h4>
                        <xsl:for-each select="OtherInformation">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 12 -->
    <xsl:template match="EcologicalInformation">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section12"/>
            </h2>
            <ol>
                <!-- Toxicity -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.1"/>
                    </h3>
                    <xsl:if test="EcotoxicologicalInformation">
                        <strong class="text-danger">Error: Section 12.1 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Persistence and degradability -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.2"/>
                    </h3>
                    <xsl:if test="PersistenceDegradability">
                        <strong class="text-danger">Error: Section 12.2 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Bioaccumulative potential -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.3"/>
                    </h3>
                    <xsl:if test="Bioaccumulation">
                        <strong class="text-danger">Error: Section 12.3 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Mobility in soilMobility in soil -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.4"/>
                    </h3>
                    <xsl:if test="Mobility">
                        <strong class="text-danger">Error: Section 12.4 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Results of PBT and vPvB assessment -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.5"/>
                    </h3>
                    <xsl:if test="ResultsOfPbtAndVpvbAssessment">
                        <strong class="text-danger">Error: Section 12.5 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Endocrine disrupting properties -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.6"/>
                    </h3>
                    <xsl:if test="OtherAdverseEffects/EndocrineDisruptingPotential">
                        <strong class="text-danger">Error: Section 12.6 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Other adverse effects -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section12.7"/>
                    </h3>
                    <xsl:if test="AdditionalEcotoxInformation/AdditionalInformation">
                        <h4>
                            <xsl:value-of select="$Section12.7-AdditionalInformation"/>
                        </h4>
                        <xsl:for-each select="AdditionalEcotoxInformation/AdditionalInformation">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 13 -->
    <xsl:template match="DisposalConsiderations">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section13"/>
            </h2>
            <ol>
                <!-- Waste treatment methods -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section13.1"/>
                    </h3>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 14 -->
    <xsl:template match="TransportInformation">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section14"/>
            </h2>
            <ol>
                <li>
                    <table class="table table-bordered table-hover table-sm">
                        <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">
                                    <xsl:value-of select="$Section14-AdrRid"/>
                                </th>
                                <th scope="col">
                                    <xsl:value-of select="$Section14-Imdg"/>
                                </th>
                                <th scope="col">
                                    <xsl:value-of select="$Section14-IcaoIata"/>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- UN number or ID number -->
                            <tr>
                                <th scope="row">
                                    <h3>
                                        <xsl:value-of select="$Section14.1"/>
                                    </h3>
                                </th>
                                <xsl:call-template name="TransportUnNumbers-Cells">
                                    <xsl:with-param name="TransportUnNumbers" select="UnNo"/>
                                </xsl:call-template>
                            </tr>

                            <!-- UN Proper shipping name -->
                            <tr>
                                <th scope="row">
                                    <h3>
                                        <xsl:value-of select="$Section14.2"/>
                                    </h3>
                                </th>
                                <xsl:call-template name="TransportProperShippingNames-Cells">
                                    <xsl:with-param name="TransportProperShippingNames" select="ProperShippingName"/>
                                </xsl:call-template>
                            </tr>

                            <!-- Transport hazard class(es) -->
                            <tr>
                                <th scope="row">
                                    <h3>
                                        <xsl:value-of select="$Section14.3"/>
                                    </h3>
                                </th>
                                <xsl:call-template name="TransportHazardClassifications-Cells">
                                    <xsl:with-param name="TransportHazardClassifications" select="TransportHazardClassification"/>
                                </xsl:call-template>
                            </tr>

                            <!-- Packing group -->
                            <tr>
                                <th scope="row">
                                    <h3>
                                        <xsl:value-of select="$Section14.4"/>
                                    </h3>
                                </th>
                                <xsl:call-template name="TransportPackingGroups-Cells">
                                    <xsl:with-param name="TransportPackingGroups" select="PackingGroup"/>
                                </xsl:call-template>
                            </tr>

                            <!-- Envirommental hazards -->
                            <tr>
                                <th scope="row">
                                    <h3>
                                        <xsl:value-of select="$Section14.5"/>
                                    </h3>
                                </th>
                                <td scope="row" colspan="3">
                                    <xsl:if test="EnvironmentalHazards">
                                        <strong class="text-danger">Error: Section 14.5 not implemented.</strong>
                                    </xsl:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </li>

                <!-- Special precautions for user -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section14.6"/>
                    </h3>
                    <xsl:if test="SpecialPrecautionUser">
                        <strong class="text-danger">Error: Section 14.6 not implemented.</strong>
                    </xsl:if>
                </li>

                <!-- Maritime transport in bulk according to IMO instruments -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section14.7"/>
                    </h3>
                    <xsl:if test="TransportInBulk">
                        <strong class="text-danger">Error: Section 14.7 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 15 -->
    <xsl:template match="RegulatoryInfo">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section15"/>
            </h2>
            <ol>
                <!-- Safety, health and environmental regulations/legislation specific for the substance or mixture -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section15.1"/>
                    </h3>
                    <xsl:for-each select="RegulatoryInfoAdditionalInfo">
                        <xsl:call-template name="Phrase">
                            <xsl:with-param name="Phrase" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </li>

                <!-- Chemical Safety Assessment -->
                <li>
                    <h3>
                        <xsl:value-of select="$Section15.1"/>
                    </h3>
                    <xsl:if test="ChemicalSafetyAssessmentInfo">
                        <strong class="text-danger">Error: Section 15.1 not implemented.</strong>
                    </xsl:if>
                </li>
            </ol>
        </div>
    </xsl:template>

    <!-- Section 16 -->
    <xsl:template match="OtherInformation">
        <div class="section">
            <h2>
                <xsl:value-of select="$Section16"/>
            </h2>
            <ol>
                <!-- Indication of changes -->
                <xsl:if test="RevisionInformation/RevisionComments">
                    <li>
                        <h3>
                            <xsl:value-of select="$Section16-RevisionInformation"/>
                        </h3>
                        <xsl:if test="RevisionInformation/RevisionComments">
                            <xsl:call-template name="Phrase">
                                <xsl:with-param name="Phrase" select="RevisionInformation/RevisionComments"/>
                            </xsl:call-template>
                        </xsl:if>
                    </li>
                </xsl:if>
            </ol>
        </div>
    </xsl:template>

</xsl:stylesheet>