<?xml version="1.0" encoding="UTF-8"?>
<!--
    SDScom XSL style sheet 4.4
    Style sheet to enable a HTML-based view of Safety Data Sheets (SDS) as specified in the SDScom XML Format.
    For detailed information please refer to https://www.eSDScom.eu
-->

<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:SDSCom="http://www.esdscom.eu/SDScom" version="3.0">
    <xsl:include href="SDSComXSLCT_EN.xsl"/>
    <xsl:include href="SDSComXSLDT_EN.xsl"/>
    <xsl:include href="SDSComXSL.xsl"/>

    <!-- Title -->
    <xsl:variable name="Title" select="'GHS SDS'"/>

    <!-- Header -->
    <xsl:variable name="Header" select="'Safety Data Sheet'"/>
    <xsl:variable name="SubHeader" select="'according to Regulation (EC) No 1907/2006 (REACH)'"/>
    <xsl:variable name="HeaderTradeName" select="'Trade name'"/>
    <xsl:variable name="HeaderProductNo" select="'Product No'"/>
    <xsl:variable name="HeaderVersion" select="'Version'"/>
    <xsl:variable name="HeaderExportDate" select="'Print date'"/>
    <xsl:variable name="HeaderRevisionDate" select="'Revision date'"/>
    
    <!-- Sections -->
    <xsl:variable name="Section" select="'Section'"/>

    <!-- Section 1 -->
    <xsl:variable name="Section1" select="'Identification of the substance/mixture and of the company/undertaking'"/>
    <xsl:variable name="Section1.1" select="'Product identifier'"/>
    <xsl:variable name="Section1.1-TradeName" select="'Trade name / designation'"/>
    <xsl:variable name="Section1.1-OtherId" select="'Other means of identification'"/>
    <xsl:variable name="Section1.1-ItemNo" select="'Item No'"/>
    <xsl:variable name="Section1.1-ProductNo" select="'Product No'"/>
    <xsl:variable name="Section1.1-ProductGtin" select="'GTIN'"/>
    <xsl:variable name="Section1.2" select="'Relevant identified uses of the substance or mixture and uses advised against'"/>
    <xsl:variable name="Section1.2-MainIntendedUse" select="'Main intended use'"/>
    <xsl:variable name="Section1.2-RelevantIdentifiedUse" select="'Relevant identified uses'"/>
    <xsl:variable name="Section1.2-UseAdvisedAgainst" select="'Uses advised against'"/>
    <xsl:variable name="Section1.3" select="'Details of the supplier of the safety data sheet'"/>
    <xsl:variable name="Section1.3-Name" select="'Name'"/>
    <xsl:variable name="Section1.3-VisitingAddress" select="'Visiting address'"/>
    <xsl:variable name="Section1.3-PostAddress" select="'Post address'"/>
    <xsl:variable name="Section1.3-Phone" select="'Telephone number'"/>
    <xsl:variable name="Section1.3-Email" select="'E-Mail'"/>
    <xsl:variable name="Section1.3-CompanyUrl" select="'Company URL'"/>
    <xsl:variable name="Section1.3-CompanyContactName" select="'Information contact'"/>
    <xsl:variable name="Section1.3-CompanyContactEmail" select="$Section1.3-Email"/>
    <xsl:variable name="Section1.3-CompanyContactEmailCompetentPerson" select="'E-Mail (competent person)'"/>
    <xsl:variable name="Section1.3-Duns" select="'D-U-N-S'"/>
    <xsl:variable name="Section1.4" select="'EMERGENCY TELEPHONE NUMBER'"/>

    <!-- Section 2 -->
    <xsl:variable name="Section2" select="'Hazards identification'"/>
    <xsl:variable name="Section2.1" select="'Classification of the substance or mixture'"/>
    <xsl:variable name="Section2.2" select="'Label elements'"/>
    <xsl:variable name="Section2.2-HazardLabelling" select="'Labelling according to Regulation (EC) No 1272/2008 [CLP/GHS]'"/>
    <xsl:variable name="Section2.3" select="'Other hazards'"/>
    <xsl:variable name="Section2.3-OtherHazards" select="'Other adverse hazards'"/>

    <!-- Section 3 -->
    <xsl:variable name="Section3" select="'Composition/information on ingredients'"/>
    <xsl:variable name="Section3-NA" select="'not applicable'"/>
    <xsl:variable name="Section3.1" select="'Substances'"/>
    <xsl:variable name="Section3.2" select="'Mixtures'"/>
    <xsl:variable name="Section3.2-ChemicalCharacterization" select="'Description of the mixture'"/>
    <xsl:variable name="Section3.2-Component" select="'Hazardous ingredients'"/>
    <xsl:variable name="Section3.2-ComponentSubstanceName" select="'Substance name'"/>
    <xsl:variable name="Section3.2-ComponentSubstanceCasNo" select="'CAS No'"/>
    <xsl:variable name="Section3.2-ComponentSubstanceEcNo" select="'EC No'"/>
    <xsl:variable name="Section3.2-ComponentConcentration" select="'Concentration'"/>
    <xsl:variable name="Section3.2-ComponentClassificationClpHazardClassification" select="'Classification according Regulation (EC) No. 1272 [CLP]'"/>

    <!-- Section 4 -->
    <xsl:variable name="Section4" select="'First aid measures'"/>
    <xsl:variable name="Section4.1" select="'Description of first aid measures'"/>
    <xsl:variable name="Section4.1-FirstAidSkin" select="'Following skin contact'"/>
    <xsl:variable name="Section4.1-FirstAidEye" select="'Following eye contact'"/>
    <xsl:variable name="Section4.1-FirstAidIngestion" select="'Following ingestion'"/>
    <xsl:variable name="Section4.2" select="'Most important symptoms and effects, both acute and delayed'"/>
    <xsl:variable name="Section4.3" select="'Indication of any immediate medical attention and special treatment needed'"/>

    <!-- Section 5 -->
    <xsl:variable name="Section5" select="'Firefighting measures'"/>
    <xsl:variable name="Section5.1" select="'Extinguishing media'"/>
    <xsl:variable name="Section5.1-MediaToBeUsed" select="'Suitable extinguishing media'"/>
    <xsl:variable name="Section5.2" select="'Special hazards arising from the substance or mixture'"/>
    <xsl:variable name="Section5.2-HazardCombustionProd" select="'Hazardous combustion products'"/>
    <xsl:variable name="Section5.3" select="'Advice for fire-fighters'"/>

    <!-- Section 6 -->
    <xsl:variable name="Section6" select="'Accidental release measures'"/>
    <xsl:variable name="Section6.1" select="'Personal precautions, protective equipment and emergency procedures'"/>
    <xsl:variable name="Section6.1-ForNonEmergencyPersonnel" select="'For non-emergency personnel'"/>
    <xsl:variable name="Section6.1-ForNonEmergencyPersonnelPersonalPrecautions" select="'Personal precautions'"/>
    <xsl:variable name="Section6.2" select="'Environmental precautions'"/>
    <xsl:variable name="Section6.3" select="'Methods and material for containment and cleaning up'"/>
    <xsl:variable name="Section6.3-Containment" select="'Methods and material for containment and cleaning up'"/>
    <xsl:variable name="Section6.4" select="'Reference to other sections'"/>

    <!-- Section 7 -->
    <xsl:variable name="Section7" select="'Handling and storage'"/>
    <xsl:variable name="Section7.1" select="'Precautions for safe handling'"/>
    <xsl:variable name="Section7.1-PrecautionaryMeasures" select="'Protective measures'"/>
    <xsl:variable name="Section7.1-PrecautionaryMeasuresToPreventFire" select="'Fire preventions'"/>
    <xsl:variable name="Section7.1-PrecautionaryMeasuresToPreventAerosolAndDust" select="'Aerosol and dust generation preventions'"/>
    <xsl:variable name="Section7.2" select="'Conditions for safe storage, including any incompatibilities'"/>
    <xsl:variable name="Section7.2-RequirementsForStorageRoomsAndVessels" select="'Requirements for storage rooms and vessels'"/>
    <xsl:variable name="Section7.3" select="'Specific end uses'"/>

    <!-- Section 8 -->
    <xsl:variable name="Section8" select="'Exposure controls/personal protection'"/>
    <xsl:variable name="Section8.1" select="'Control parameters'"/>
    <xsl:variable name="Section8.2" select="'Exposure controls'"/>

    <!-- Section 9 -->
    <xsl:variable name="Section9" select="'Physical and chemical properties'"/>
    <xsl:variable name="Section9.1" select="'Information on basic physical and chemical properties'"/>
    <xsl:variable name="Section9.1-Appearance" select="'Appearance'"/>
    <xsl:variable name="Section9.1-AppearanceForm" select="'Physical state'"/>
    <xsl:variable name="Section9.1-SafetyRelevantInformationValue" select="'Value'"/>
    <xsl:variable name="Section9.1-SafetyRelevantInformationMeltingPoint" select="'Melting point'"/>
    <xsl:variable name="Section9.2" select="'Other information'"/>

    <!-- Section 10 -->
    <xsl:variable name="Section10" select="'Stability and reactivity'"/>
    <xsl:variable name="Section10.1" select="'Reactivity'"/>
    <xsl:variable name="Section10.2" select="'Chemical stability'"/>
    <xsl:variable name="Section10.3" select="'Possibility of hazardous reactions'"/>
    <xsl:variable name="Section10.4" select="'Conditions to avoid'"/>
    <xsl:variable name="Section10.5" select="'Incompatible materials'"/>
    <xsl:variable name="Section10.6" select="'Hazardous decomposition products'"/>

    <!-- Section 11 -->
    <xsl:variable name="Section11" select="'Toxicological information'"/>
    <xsl:variable name="Section11.1" select="'Information on hazard classes as defined in Regulation (EC) No 1272/2008'"/>
    <xsl:variable name="Section11.2" select="'Information on other hazards'"/>
    <xsl:variable name="Section11.2-OtherInformation" select="'Other information'"/>

    <!-- Section 12 -->
    <xsl:variable name="Section12" select="'Ecological information'"/>
    <xsl:variable name="Section12.1" select="'Toxicity'"/>
    <xsl:variable name="Section12.2" select="'Persistence and degradability'"/>
    <xsl:variable name="Section12.3" select="'Bioaccumulative potential'"/>
    <xsl:variable name="Section12.4" select="'Mobility in soil'"/>
    <xsl:variable name="Section12.5" select="'Results of PBT and vPvB assessment'"/>
    <xsl:variable name="Section12.6" select="'Endocrine disrupting properties'"/>
    <xsl:variable name="Section12.7" select="'Other adverse effects'"/>
    <xsl:variable name="Section12.7-AdditionalInformation" select="'Additional ecotoxicological information'"/>

    <!-- Section 13 -->
    <xsl:variable name="Section13" select="'Disposal considerations'"/>
    <xsl:variable name="Section13.1" select="'Waste treatment methods'"/>

    <!-- Section 14 -->
    <xsl:variable name="Section14" select="'Transport information'"/>
    <xsl:variable name="Section14-AdrRid" select="'Land transport (ADR/RID)'"/>
    <xsl:variable name="Section14-Imdg" select="'Sea transport (IMDG)'"/>
    <xsl:variable name="Section14-IcaoIata" select="'Air transport (ICAO-TI / IATA-DGR)'"/>
    <xsl:variable name="Section14.1" select="'UN number or ID number'"/>
    <xsl:variable name="Section14.2" select="'UN Proper shipping name'"/>
    <xsl:variable name="Section14.3" select="'Transport hazard class(es)'"/>
    <xsl:variable name="Section14.4" select="'Packing group'"/>
    <xsl:variable name="Section14.5" select="'Envirommental hazards'"/>
    <xsl:variable name="Section14.6" select="'Special precautions for user'"/>
    <xsl:variable name="Section14.7" select="'Maritime transport in bulk according to IMO instruments'"/>

    <!-- Section 15 -->
    <xsl:variable name="Section15" select="'Regulatory information'"/>
    <xsl:variable name="Section15.1" select="'Safety, health and environmental regulations/legislation specific for the substance or mixture'"/>
    <xsl:variable name="Section15.2" select="'Chemical Safety Assessment'"/>

    <!-- Section 16 -->
    <xsl:variable name="Section16" select="'Other information'"/>
    <xsl:variable name="Section16.1" select="'Indication of changes'"/>
    <xsl:variable name="Section16.2" select="'Abbreviations and acronyms'"/>
    <xsl:variable name="Section16.3" select="'Key literature references and sources for data'"/>
    <xsl:variable name="Section16.4" select="'Classification for mixtures and used evaluation method according to regulation (EC) 1207/2008 [CLP]'"/>
    <xsl:variable name="Section16.5" select="'Relevant H- and EUH-phrases (number and full text)'"/>
    <xsl:variable name="Section16.6" select="'Training advice'"/>
    <xsl:variable name="Section16.7" select="'Further information'"/>
</xsl:stylesheet>