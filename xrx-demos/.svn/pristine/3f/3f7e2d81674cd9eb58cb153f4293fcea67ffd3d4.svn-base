xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xf="http://www.w3.org/2002/xforms";

let $title := 'Edit Term'

let $set-header-1 := response:set-header("Cache-Control", 'no-cache')
let $set-header-2 := response:set-header("pragma", 'no-cache')

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $user := xmldb:get-current-user()
let $form := 'Term Editor'
let $form-version := '0.10'

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for this web service.</message>
    </error>)
    else
        let $app-collection := $style:db-path-to-app
        let $data-collection := concat($app-collection, '/data')
        
(: put in the appropriate file name :)
let $file := if ($new)
   then ('new-instance.xml')
   else concat('get-instance.xq?id=', $id)

let $model :=
<xf:model>

    <xf:instance xmlns="" id="save-data" src="{$file}"/>
    
    <!-- code tables -->
    <xf:instance xmlns="" id="code-tables" src="all-codes.xq"/>
    
    <!-- this is the place that we store the parameters that are going out to the remote suggest service -->
    <xf:instance id="suggest-query">
    <data xmlns="">
        <q/>
    </data>
    </xf:instance>
    
    <xf:instance xmlns="" id="search-results">
       <data>
          <term>
             <id>0</id>
             <term-name>null</term-name>
          </term>
       </data>
    </xf:instance>

    <xf:bind nodeset="instance('save-data')/term-name" required="true()"/>
    <xf:bind nodeset="instance('save-data')/definition" required="true()"/>
    <!-- <xf:bind nodeset="instance('save-data')/ApprovalDate" type="xs:date"/> -->
    
    <!-- these do not work since the form will not submit with a null date -->
    <xf:bind nodeset="instance('save-data')/ApprovalDate" required="false()" nillable="true()"/>
    
    <xf:bind nodeset="instance('save-data')/GroupStarredItemIndicator" type="xs:boolean"/>
    <xf:bind nodeset="instance('save-data')/DataElementIndicator" type="xs:boolean"/>
    <xf:bind nodeset="instance('save-data')/DataElementIdentifierIndicator" type="xs:boolean"/>
    <xf:bind nodeset="instance('save-data')/DataElementDerivedIndicator" type="xs:boolean"/>
    <xf:bind nodeset="instance('save-data')/GroupStarredItemIndicator" required="false()"/>
    <!-- these are used to bind to conditional views or triggers-->
    <xf:instance xmlns="" id="views">
        <data>
            <approved/>
            <synonym-delete-trigger/>                    
            <see-also-delete-trigger/>
            <broader-delete-trigger/>
            <narrower-delete-trigger/>
            <tag-delete-trigger/>
            <other-source/>
            <data-element/>
            <data-element-derived/>
        </data>
    </xf:instance>
    <!-- only display the delete triggers if there is more than one item on the list -->
    
    <xf:bind nodeset="instance('save-data')/PreferredTermIndicator" type="xs:boolean"/>
    <xf:bind id="approved" nodeset="instance('views')/approved" relevant="instance('save-data')/ApprovalStatusCode='program-approved'"/>
    <xf:bind id="synonym-delete-trigger" nodeset="instance('views')/synonym-delete-trigger" relevant="count(instance('save-data')/Synonym)  > 1"/>            
    <xf:bind id="see-also-delete-trigger" nodeset="instance('views')/see-also-delete-trigger" relevant="count(instance('save-data')/SeeAlso) &gt; 1"/>
    
    <!-- only for multiple inheritence models <xf:bind id="broader-delete-trigger" nodeset="instance('views')/broader-delete-trigger" relevant="count(instance('save-data')/Broader) &gt; 1"/>
    -->
    <xf:bind id="tag-delete-trigger" nodeset="instance('views')/tag-delete-trigger" relevant="count(instance('save-data')/tag) &gt; 1"/>
    <xf:bind id="other-source" nodeset="instance('views')/other-source" relevant="instance('save-data')/PrimarySourceCode='other' "/>
    <xf:bind id="data-element" nodeset="instance('views')/data-element" relevant="instance('save-data')/DataElementIndicator='true' "/>
    <xf:bind id="data-element-derived" nodeset="instance('views')/data-element-derived" relevant="instance('save-data')/DataElementDerivedIndicator='true' "/>
    
    {if ($new='true')
    then 
    <xf:bind nodeset="instance('save-data')/ApprovalDate" calculate="substring(now(), 1, 10)"/>
    else ()}
    

    
    <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="save-data" replace="all"/>
    
    <xf:submission id="get-suggestions" action="../search/starts-with.xq" 
            method="get" separator="&amp;" 
            ref="instance('suggest-query')" 
            replace="instance" instance="search-results">
        </xf:submission>
    <!--
        <xf:submission id="echo-test" method="post" action="{$server-port}/exist/rest/db/dma/xqueries/echo-test.xq" instance="save-data" replace="all"/>
    -->
</xf:model>
 
let $content :=
<div class="content">
    <h1>{if ($new='true') then ('New') else ('Update')} Glossary Term</h1>
    <p>{$form} - {$form-version} - File: {$file}</p>
    
    <xf:submit submission="save">
            <xf:label>Save</xf:label>
   </xf:submit>
    <xf:group ref="instance('save-data')">
        <xf:label class="group-label">Glossary Term</xf:label>
        <div class="block-form">
            <xf:input ref="term-name" class="term-name">
                <xf:label>Term Name:</xf:label>
                <xf:hint>The name of a term in the glossary.</xf:hint>
            </xf:input>
            <xf:input ref="abbreviation" class="abbreviation">
                <xf:label>Acronym:</xf:label>
                <xf:hint>The acronym or abbreviation for this term.</xf:hint>
            </xf:input>
            <xf:input ref="SynonymID">
                <xf:label>Synonym Set ID:</xf:label>
                <xf:hint>A link to the Synonym Set Editor.</xf:hint>
            </xf:input>
            <xf:textarea class="definition" ref="definition">
                <xf:label>Definition:</xf:label>
                <xf:hint>A short, precise, non-circular definition for this term that clearly differentiates this term
                    from other terms.</xf:hint>
            </xf:textarea>
        </div>
        <xf:group>
            <xf:label class="group-label">Select Categories</xf:label>
            <xf:repeat id="see-also-repeat" nodeset="instance('save-data')/see-also-term-id">
                <xf:input ref="." class="SeeAlso inline-delete">
                    <xf:label>See Also (non-synonym):</xf:label>
                    <xf:hint>A related term in the glossary that is not a synonym.</xf:hint>
                </xf:input>
                <xf:trigger bind="see-also-delete-trigger" class="inline-delete">
                    <xf:label>Delete See Also</xf:label>
                    <xf:delete nodeset="." ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Insert New "See Also" Term</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/see-also-term-id" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/see-also-term-id[index('see-also-repeat')]" value=""/>
                    <xf:setfocus control="see-also-input"/>
                </xf:action>
            </xf:trigger>
        </xf:group>
        
        <div class="block-form">
            <xf:input ref="instance('save-data')/broader-term-id">
                <xf:label>Broader Term:</xf:label>
                <xf:hint>A term that is more general in meaning.</xf:hint>
            </xf:input>
        </div>
        <xf:repeat nodeset="instance('search-results')/term">
           <xf:output ref="id"/>
           <xf:output ref="term-name"/>
        </xf:repeat>
        
        <xf:group>
            <xf:label class="group-label">Definition Sources</xf:label>
            <xf:repeat id="source-repeat" nodeset="instance('save-data')/PrimarySourceCode">
                <xf:select1 ref="." class="inline-delete" id="source-select">
                    <xf:label>Definition Source:</xf:label>
                    <xf:hint>The source of information about the term and its defintion.</xf:hint>
                    <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='SourceCode']/item">
                        <xf:label ref="label"/>
                        <xf:value ref="value"/>
                    </xf:itemset>
                </xf:select1>
                <xf:trigger bind="tag-delete-trigger" class="inline-delete">
                    <xf:label>Delete Source</xf:label>
                    <xf:delete nodeset="instance('save-data')/PrimarySourceCode[index('source-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add New Source</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/PrimarySourceCode" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/PrimarySourceCode[index('source-repeat')]" value=""/>
                    <xf:setfocus control="source-select"/>
                </xf:action>
            </xf:trigger>
        </xf:group>
        
        <!-- bind="other-source" -->
        <xf:group ref="instance('views')/other-source">
            <xf:input ref="instance('save-data')/PrimarySourceOtherText">
                <xf:label>Other Source: </xf:label>
            </xf:input>
        </xf:group>
        <xf:group>
            <xf:label class="group-label">Projects</xf:label>
            <xf:repeat id="project-repeat" nodeset="instance('save-data')/ProjectCode">
                <xf:select1 ref="." class="inline-delete" id="project-select">
                    <xf:label>Project:</xf:label>
                    <xf:hint>A code for classifying all the data elements.</xf:hint>
                    <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='ProjectCode']/item">
                        <xf:label ref="label"/>
                        <xf:value ref="value"/>
                    </xf:itemset>
                </xf:select1>
                <xf:trigger bind="tag-delete-trigger" class="inline-delete">
                    <xf:label>Delete Project</xf:label>
                    <xf:delete nodeset="instance('save-data')/ProjectCode[index('project-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add New Project</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/ProjectCode" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/ProjectCode[index('project-repeat')]" value=""/>
                    <xf:setfocus control="project-select"/>
                </xf:action>
            </xf:trigger>
        </xf:group>
        <div class="block-form">
            <xf:select1 ref="instance('save-data')/assigned-to-person-id">
                <xf:label>Assigned to Facilitate Approval:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='AssignedToCode']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
            
            <xf:select1 ref="instance('save-data')/ApprovalStatusCode" class="block-form">
                <xf:label>Approval Status:</xf:label>
                <xf:item>
                    <xf:label>Initial Draft</xf:label>
                    <xf:value>initial-draft</xf:value>
                </xf:item>
                <xf:item>
                    <xf:label>Assigned for Review</xf:label>
                    <xf:value>assigned-to-review-team</xf:value>
                </xf:item>
                <xf:item>
                    <xf:label>Program Approved</xf:label>
                    <xf:value>program-approved</xf:value>
                </xf:item>
            </xf:select1>
        </div>
        <xf:group ref="instance('views')/approved">
            <xf:select1 ref="instance('save-data')/ApprovedByCode">
                <xf:label>Approved By:</xf:label>
                <xf:hint>The person or organization that approved this term.</xf:hint>
                <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='ApprovedByCode']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
            <br/>
            <xf:input ref="instance('save-data')/ApprovalDate">
                <xf:label>Approval Date:</xf:label>
                <xf:hint>The date that this term was approved.</xf:hint>
            </xf:input>
        </xf:group>
        <xf:input ref="instance('save-data')/GroupStarredItemIndicator">
            <xf:label>Starred Item:</xf:label>
            <xf:hint>An indication by the group that this item needs attention.</xf:hint>
        </xf:input>
        <xf:group>
            <xf:label class="group-label">Classifiers</xf:label>
            <xf:repeat id="classifier-repeat" nodeset="instance('save-data')/ClassifierCode">
                <xf:select1 ref="." class="inline-delete" id="classifier-select">
                    <xf:label>Classifier (Filter) Code:</xf:label>
                    <xf:hint>A code for classifying all the data elements.</xf:hint>
                    <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='ClassifierCode']/item">
                        <xf:label ref="label"/>
                        <xf:value ref="value"/>
                    </xf:itemset>
                </xf:select1>
                <xf:trigger bind="tag-delete-trigger" class="inline-delete">
                    <xf:label>Delete Classifier (Filter)</xf:label>
                    <xf:delete nodeset="instance('save-data')/ClassifierCode[index('classifier-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Add New Classifier (Filter)</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/ClassifierCode" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/ClassifierCode[index('classifier-repeat')]" value=""/>
                    <xf:setfocus control="classifier-select"/>
                </xf:action>
            </xf:trigger>
        </xf:group>
        <xf:group>
            <xf:label class="group-label">Tags</xf:label>
            <xf:repeat id="tag-repeat" nodeset="instance('save-data')/Tag">
                <xf:input ref="." class="Tag inline-delete" id="tag-input">
                    <xf:label>Tag (Keyword):</xf:label>
                </xf:input>
                <xf:trigger bind="tag-delete-trigger" class="inline-delete">
                    <xf:label>Delete Tag (Keyword)</xf:label>
                    <xf:delete nodeset="instance('save-data')/Tag[index('tag-repeat')]" ev:event="DOMActivate"/>
                </xf:trigger>
            </xf:repeat>
            <xf:trigger>
                <xf:label>Append New Tag (Keyword)</xf:label>
                <xf:action ev:event="DOMActivate">
                    <xf:insert nodeset="instance('save-data')/Tag" at="last()" position="after"/>
                    <xf:setvalue ref="instance('save-data')/Tag[index('tag-repeat')]" value=""/>
                    <xf:setfocus control="tag-input"/>
                </xf:action>
            </xf:trigger>
        </xf:group>
        <xf:textarea ref="instance('save-data')/TermNoteText" class="block-form Notes">
            <xf:label>General notes:</xf:label>
            <xf:hint>Any related notes about this term.</xf:hint>
        </xf:textarea>
        <xf:input ref="instance('save-data')/DataElementIndicator" class="block-form">
            <xf:label>Candidate Data Term:</xf:label>
            <xf:hint>This  term has a mapping to a registered data element.</xf:hint>
        </xf:input>
        <xf:group ref="instance('views')/data-element">
            <br/>
            <xf:input ref="instance('save-data')/DataElementDerivedIndicator">
                <xf:label>Data Element Derived:</xf:label>
                <xf:hint>This data element is derived from other data elements.</xf:hint>
            </xf:input>
            <xf:group ref="instance('views')/data-element-derived">
                <xf:textarea class="large-textarea" ref="instance('save-data')/DataElementDerivationRuleText">
                    <xf:label>Derivation Rules:</xf:label>
                    <xf:hint>Any rules used to derive this data element from other data elements.</xf:hint>
                </xf:textarea>
            </xf:group>
            <xf:input ref="instance('save-data')/DataElementIdentifierIndicator" class="block-form">
                <xf:label>Data Element Identifier:</xf:label>
                <xf:hint>This data element is use to identify data sets.</xf:hint>
            </xf:input>
            <xf:textarea class="large-textarea block-form" ref="instance('save-data')/DataElementEnumerationsText">
                <xf:label>Enumerations (Valid Codes):</xf:label>
                <xf:hint>A listing of all valid values and definitions for the possible values of this data element.</xf:hint>
            </xf:textarea>
            <xf:textarea class="large-textarea block-form" ref="instance('save-data')/DataElementValidationRulesText">
                <xf:label>Validation Rules:</xf:label>
                <xf:hint>Any rules used to validate this data element.</xf:hint>
            </xf:textarea>
            <xf:input ref="instance('save-data')/DataElementName" class="DataElementName block-form">
                <xf:label>Data Element Name:</xf:label>
                <xf:hint>ISO name for this data element including the ObjectClass, Property and Representation Term using an UpperCamelCase notation.</xf:hint>
            </xf:input>
        </xf:group>
        <br/>
        <br/>
        <br/>
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>
    </xf:group>
</div>

return style:assemble-form($title, (), (), $model, $content, true() )

