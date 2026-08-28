<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:import href="../../../../../../../../sdk2/internal/pdf_generator/pdf_generator.xsl"/>

    <!-- ############################################################################
         START HERE — xsl_ps2.xsl
         Controls document structure, section order, and metadata sourcing.

         SAFE TO EDIT
         - Enable/disable sections (cover, TOC, front matter, back cover)
         - Enable/disable cover metadata fields (uncomment call-template lines)


         EDIT ELSEWHERE
         - Metadata values            - ditamap topicmeta
         - Visual appearance          - style_ps2.css

         CHANGE CAREFULLY
         - chapterBody template (document assembly order)
         - Metadata extraction logic within each cover.meta.* template
         ############################################################################ -->

    <!-- ========================================================
         CHAPTER BODY — controls document assembly order.
         Enable or disable sections by commenting/uncommenting
         the call-template lines below.
         ======================================================== -->
    <xsl:template match="*[contains(@class, ' map/map ')]" mode="chapterBody">
        <body>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]/@outputclass" mode="add-ditaval-style"/>
            <xsl:if test="@outputclass">
                <xsl:attribute name="class" select="@outputclass"/>
            </xsl:if>
            <xsl:apply-templates select="." mode="addAttributesToBody"/>
            <xsl:call-template name="setidaname"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
            <xsl:call-template name="generateBreadcrumbs"/>
            <xsl:call-template name="gen-user-header"/>
            <xsl:call-template name="processHDR"/>
            <xsl:if test="$INDEXSHOW = 'yes'">
                <xsl:apply-templates select="/*/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]"/>
            </xsl:if>
            <xsl:call-template name="gen-user-sidetoc"/>

            <!-- ################################################################# -->
            <!-- SECTION TOGGLES — Enable or disable major PDF sections.
                 To turn a section off, wrap its line in comment markers.
                 To turn a section on, remove the comment markers.
                 Order here controls order in the output document. -->
            <!-- ################################################################# -->

            <!-- Cover page -->
            <xsl:call-template name="front.cover"/>
            <xsl:call-template name="frontmatter.page"/>
            <!-- Table of contents -->
            <xsl:variable name="map" as="element()*">
                <xsl:apply-templates select="." mode="normalize-map"/>
            </xsl:variable>
            <xsl:apply-templates select="$map" mode="toc"/>

            <!-- Body content (always required — do not disable) -->
            <xsl:call-template name="gen-user-footer"/>
            <xsl:call-template name="processFTR"/>
            <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
            <xsl:apply-templates select="/normalized/*[contains(@class, ' topic/topic ')]                 [not(@id = /normalized/map//*[contains(@class, ' map/topicref ')][@outputclass='front-matter']/@href/substring-after(., '#'))]" mode="child.topic"/>

            <xsl:call-template name="back.cover"/>
        </body>
    </xsl:template>

    <!-- ========================================================
         FRONT COVER
         ======================================================== -->
    <xsl:template name="front.cover">
        <div class="cover-page-container">
            <div class="cover-page-content">
                <div class="cover-top-area">
                    <div class="text-wrapper">
                        <div class="cover-title">
                            <xsl:call-template name="get.map.title"/>
                        </div>
                        <xsl:call-template name="cover.meta.subtitle"/>
                    </div>
                </div>

                <div class="cover-meta-block">

                    <!-- ################################ -->
                    <!-- COVER METADATA — Optional fields displayed in the white band below the cover image,
                         to the left of the logo. To enable a field, remove the comment markers around
                         its call-template line. Fields appear in the order listed below.
                         Each field is safe to enable or remove independently — no other fields,
                         page numbering, or document flow will be affected.
                         NOTE: subtitle is always shown and is rendered above in the title block,
                         not here. To hide it, remove its call-template from the text-wrapper above -->
                    <!-- ################################ -->

                    <!-- Product name — source: <prodname> in <prodinfo> -->
                    <xsl:call-template name="cover.meta.prodname"/>

                    <!-- Version — source: <vrm version="" release="" modification=""> in <vrmlist> -->
                    <xsl:call-template name="cover.meta.version"/>

                    <!-- Platform — source: <platform> in <prodinfo>                                      -->
                    <xsl:call-template name="cover.meta.platform"/>

                    <!-- Part number — source: <bookpartno> (bookmap) or <data name="part-number">        -->
                    <!-- <xsl:call-template name="cover.meta.part-number"/> -->

                    <!-- Document revision — source: <edition> (bookmap) or <data name="doc-revision">   -->
                    <xsl:call-template name="cover.meta.doc-revision"/>

                    <!-- Audience — source: <audience type=""> in topicmeta/bookmeta                      -->
                    <!-- <xsl:call-template name="cover.meta.audience"/> -->

                    <!-- Author — source: <author> in topicmeta/bookmeta                                  -->
                    <xsl:call-template name="cover.meta.author"/>

                    <!-- Publisher — source: <publisher> (map) or <organization> (bookmap)                -->
                    <!-- <xsl:call-template name="cover.meta.publisher"/> -->

                    <!-- Creation date — source: <created date=""> in <critdates>                         -->
                    <xsl:call-template name="cover.meta.created"/>

                    <!-- Last revised date — source: <revised modified=""> in <critdates>                 -->
                    <!-- <xsl:call-template name="cover.meta.revised"/> -->

                    <!-- Copyright has moved to the back cover. -->

                </div>

                <div class="cover-logo"/>
            </div>
        </div>
    </xsl:template>

    <!-- ========================================================
         COVER METADATA TEMPLATES
         ======================================================== -->

    <xsl:template name="cover.meta.subtitle">
        <xsl:variable name="v" select="(/normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]                                         //*[contains(@class, ' topic/data ')][@name='subtitle'])[1]/@value"/>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-subtitle">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.prodname">
        <xsl:variable name="v" select="normalize-space((/normalized//*[contains(@class, ' topic/prodname ')])[1])"/>
        <xsl:if test="$v != ''">
            <div class="cover-meta-item cover-prodname">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.version">
        <xsl:variable name="vrm" select="(/normalized//*[contains(@class, ' topic/vrm ')])[1]"/>
        <xsl:if test="$vrm">
            <xsl:variable name="v" select="normalize-space($vrm/@version)"/>
            <xsl:variable name="r" select="normalize-space($vrm/@release)"/>
            <xsl:variable name="m" select="normalize-space($vrm/@modification)"/>
            <xsl:variable name="version-str">
                <xsl:if test="$v != ''">
                    <xsl:value-of select="$v"/>
                    <xsl:if test="$r != ''">
                        <xsl:text>.</xsl:text><xsl:value-of select="$r"/>
                        <xsl:if test="$m != ''">
                            <xsl:text>.</xsl:text><xsl:value-of select="$m"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            </xsl:variable>
            <xsl:if test="normalize-space($version-str) != ''">
                <div class="cover-meta-item cover-version">
                    <xsl:value-of select="$version-str"/>
                </div>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.platform">
        <xsl:variable name="v" select="normalize-space((/normalized//*[contains(@class, ' topic/platform ')])[1])"/>
        <xsl:if test="$v != ''">
            <div class="cover-meta-item cover-platform">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.part-number">
        <xsl:variable name="v">
            <xsl:choose>
                <xsl:when test="/normalized//*[contains(@class, ' bookmap/bookpartno ')]">
                    <xsl:value-of select="normalize-space(/normalized//*[contains(@class, ' bookmap/bookpartno ')])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="(/normalized//*[contains(@class, ' topic/data ')][@name='part-number'])[1]/@value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-partno">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.doc-revision">
        <xsl:variable name="v">
            <xsl:choose>
                <xsl:when test="/normalized//*[contains(@class, ' bookmap/edition ')]">
                    <xsl:value-of select="normalize-space(/normalized//*[contains(@class, ' bookmap/edition ')])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="(/normalized//*[contains(@class, ' topic/data ')][@name='doc-revision'])[1]/@value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-doc-revision">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.audience">
        <xsl:variable name="v" select="(             /normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]                            //*[contains(@class, ' topic/audience ')])[1]/@type"/>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-audience">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.author">
        <xsl:variable name="v" select="normalize-space((             /normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]                            //*[contains(@class, ' topic/author ')])[1])"/>
        <xsl:if test="$v != ''">
            <div class="cover-meta-item cover-author">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.publisher">
        <xsl:variable name="v">
            <xsl:choose>
                <xsl:when test="/normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]//*[contains(@class, ' topic/publisher ')]">
                    <xsl:value-of select="normalize-space((/normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]//*[contains(@class, ' topic/publisher ')])[1])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="(/normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]//*[contains(@class, ' topic/data ')][@name='company-name'])[1]/@value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-publisher">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.created">
        <xsl:variable name="v" select="(             /normalized//*[contains(@class, ' topic/critdates ')]                            /*[contains(@class, ' topic/created ')])[1]/@date"/>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-created">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.revised">
        <xsl:variable name="v" select="(             /normalized//*[contains(@class, ' topic/critdates ')]                            /*[contains(@class, ' topic/revised ')])[last()]/@modified"/>
        <xsl:if test="normalize-space($v) != ''">
            <div class="cover-meta-item cover-revised">
                <xsl:value-of select="$v"/>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="cover.meta.copyright">
        <!-- Year is always the current build year; no need to maintain <copyryear> in the map. -->
        <xsl:variable name="year" select="year-from-date(current-date())"/>
        <xsl:variable name="holder" select="normalize-space((             /normalized//*[contains(@class, ' map/topicmeta ') or contains(@class, ' bookmap/bookmeta ')]             //*[contains(@class, ' topic/copyrholder ')])[1])"/>
        <!-- Always render; © symbol is injected by .back-cover-copyright::before in CSS. -->
        <div class="back-cover-copyright">
            <xsl:value-of select="$year"/>
            <xsl:text> </xsl:text>
            <xsl:choose>
                <xsl:when test="$holder != ''">
                    <xsl:value-of select="$holder"/>
                </xsl:when>
                <xsl:otherwise>REPLACE WITH YOUR ORGANIZATION. All rights reserved.</xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- ========================================================
         BACK COVER
         To enable, add this to chapterBody:
           <xsl:call-template name="back.cover"/>
         ======================================================== -->
    <xsl:template name="back.cover">
        <div class="back-cover-page-container">
            <div class="back-cover-logo"/>
            <div class="companydetails">
                <div class="orgname">
                    <xsl:choose>
                        <xsl:when test="//*[contains(@class, ' bookmap/organization ')]">
                            <xsl:value-of select="//*[contains(@class, ' bookmap/organization ')][1]"/>
                        </xsl:when>
                        <xsl:when test="//*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')][@name='company-name']">
                            <xsl:value-of select="//*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')][@name='company-name']/@value"/>
                        </xsl:when>
                    </xsl:choose>
                </div>
                <div class="address">
                    <xsl:choose>
                        <xsl:when test="//*[contains(@class, ' bookmap/bookid ')]/*[contains(@class, ' topic/data ')][@name='address']">
                            <xsl:value-of select="//*[contains(@class, ' bookmap/bookid ')]/*[contains(@class, ' topic/data ')][@name='address']/@value"/>
                        </xsl:when>
                        <xsl:when test="//*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')][@name='address']">
                            <xsl:value-of select="//*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')][@name='address']/@value"/>
                        </xsl:when>
                    </xsl:choose>
                </div>
                <div class="url">
                    <xsl:value-of select="//*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')][@name='company-url']/@value"/>
                </div>
                <xsl:call-template name="cover.meta.copyright"/>
            </div>
        </div>
    </xsl:template>

    <!-- ========================================================
         FRONT MATTER
         To enable, add this to chapterBody (before TOC):
           <xsl:call-template name="frontmatter.page"/>
         ======================================================== -->
    <xsl:template name="frontmatter.page">
        <xsl:variable name="frontmatterContent" select="//*[contains(@class, ' bookmap/bookfrontmatter ')] | //*[contains(@class, ' map/topicref ')][@outputclass='front-matter']"/>
        <xsl:if test="$frontmatterContent">
            <div class="front-matter-container">
                <xsl:for-each select="$frontmatterContent">
                    <xsl:choose>
                        <xsl:when test="contains(@class, ' bookmap/bookfrontmatter ')">
                            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="frontmatter-content"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="frontmatter-content"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*" mode="frontmatter-content">
        <div class="front-matter-section">
            <xsl:variable name="targetId" select="substring-after(@href, '#')"/>
            <xsl:apply-templates select="//*[@id=$targetId]" mode="child.topic"/>
        </div>
    </xsl:template>

    <!-- ========================================================
         MAP TITLE
         ======================================================== -->
    <xsl:template name="get.map.title">
        <xsl:choose>
            <xsl:when test="/normalized//*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/title ')]">
                <xsl:apply-templates select="/normalized//*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/title ')]"/>
            </xsl:when>
            <xsl:when test="/normalized//*[contains(@class, ' map/map ')]/@title">
                <xsl:value-of select="/normalized//*[contains(@class, ' map/map ')]/@title"/>
            </xsl:when>
            <xsl:when test="/normalized//*[contains(@class, ' map/map ')]//*[contains(@class, ' topic/title ')]//*[contains(@class, ' bookmap/mainbooktitle ')]">
                <xsl:apply-templates select="/normalized//*[contains(@class, ' map/map ')]//*[contains(@class, ' topic/title ')]//*[contains(@class, ' bookmap/mainbooktitle ')]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:comment>No title specified</xsl:comment>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>