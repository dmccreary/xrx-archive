xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace auth='http://mdr.danmccreary.com/authentication' at '/db/mdr/modules/authentication.xqm';
(: XQuery to construct an XForm for either a new item or update item :)
declare option exist:serialize "method=xhtml media-type=application/xhtml+xml indent=yes";

let $new := request:get-parameter('new', '')
let $test := request:get-parameter('test', '')
let $id := request:get-parameter('id', '')
let $user := xmldb:get-current-user()

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')

let $data-element-base-dir := substring-before(request:get-url(), 'edit/edit.xq')

(: you can override the base collection by putting collection='/db/mdr/foo' in the URL 
let $collection := request:get-parameter('id', '/db/mdr/data-elements/data'):)

return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
      let $app-collection := style:app-base-url()
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
     let $file := if ($new)
        then ('new-instance.xml')
        else (concat($data-collection, '/', $id, '.xml'))

return
(: check for valid role :)
if (not(auth:has-role($user, 'ba')) and false())
  then
     style:html-error-message(concat('The Current user: ', $user, ' does not have Edit rights to this application.'))
  else
<html xmlns="http://www.w3.org/1999/xhtml"
   xmlns:xf="http://www.w3.org/2002/xforms"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:ev="http://www.w3.org/2001/xml-events" >
    <head>
        <title>Data Element Editor.</title>
        {style:import-css()}
        <link rel="stylesheet" type="text/css" href="edit.css"/>
        <link rel="stylesheet" type="text/css" href="enum-table-widths.css"/>
        <xf:model>
            <xf:instance xmlns="" id="de" src="{$file}"/>
            
            <xf:bind nodeset="instance('de')/DataElementName" calculate="concat(
            instance('de')/DataElementObjectClassName,
            instance('de')/DataElementPropertyName,
            instance('de')/DataElementRepresentationTerm
            )"/>
            <xf:bind nodeset="instance('de')/DataElementName" readonly="true()" />

            
            <xf:bind nodeset="instance('de')/DataElementObjectClass" required="true()"/>
            <xf:bind nodeset="instance('de')/DataElementDefinition" required="true()"/>
            <xf:bind nodeset="instance('de')/DataElementComplexIndicator" type="xs:boolean"/>
            <xf:bind nodeset="instance('de')/DataElementPropertyName" required="false()"/>
            
            <!-- The Representation term is only required if we have a property, not a complex -->
            <!-- xf:bind nodeset="instance('de')/DataElementRepresentationTerm" 
            required="instance('de')/DataElementComplexIndicator='false' "/> -->
            
            <!-- load all code tabels here-->
            <xf:instance xmlns="" id="code-tables" src="all-codes.xq"/>

            <xf:instance xmlns="" id="views">
                <data>
                    <!-- display this view for non-conceptual data elements -->
                    <property-view>true</property-view>
                    <subclass-of-view>true</subclass-of-view>
                    <!-- list of all the valid enumerated values which is only used for Codes -->
                    <enumerations-view>true</enumerations-view>
                </data>
            </xf:instance>
            
            <xf:bind nodeset="instance('views')/property-view"
                   relevant="instance('de')/DataElementComplexIndicator='false' "/>
             <xf:bind id="subclass-of-view" nodeset="instance('views')/subclass-of-view" 
                   relevant="instance('de')/DataElementComplexIndicator='true' "/>
             
            <xf:bind nodeset="instance('views')/enumerations-view" 
                  relevant="instance('de')/DataElementRepresentationTerm='Code'
                                     and instance('de')/DataElementComplexIndicator='false' "/>
             
         <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-term" replace="all"/>
         <xf:submission id="echo-test" method="post" action="{style:server-port()}/exist/rest/db/mdr/xqueries/echo-test.xq" instance="my-term" replace="all"/>
      </xf:model>
   </head>
   <body>
        {style:header()}
        {style:breadcrumb()}
        <h1>Data Element Editor</h1>
        <p>DRAFT Form v0.3</p>
            <div class="block-form">
            <xf:input ref="instance('de')/DataElementName" class="DataElementName" incremental="true">
                <xf:label>Data Element Name:</xf:label>
            </xf:input>
            
            <xf:input ref="instance('de')/DataElementObjectClassName" class="DataElementObjectClassName" incremental="true">
                <xf:label>Object Class:</xf:label>
            </xf:input>
            
              <xf:input  class="BusinessName" incremental="true">
                <xf:label>Business Name:</xf:label>
            </xf:input>
        
            <xf:input ref="instance('de')/DataElementComplexIndicator" class="DataElementComplexIndicator">
                <xf:label>Conceptual Data Element:</xf:label>
            </xf:input>
            
            <!-- 
            <xf:group ref="instance('views')/subclass-of-view">
            <xf:input ref="instance('de')/DataElementSubClassOf" class="DataElementSubClassOf">
                <xf:label>Subclass of:</xf:label>
            </xf:input> 
             </xf:group> -->
             

             
            <xf:group ref="instance('views')/property-view">
                <xf:label class="group-label">Property/Term:</xf:label>
                <xf:group ref="instance('de')">
                
                    <xf:input ref="instance('de')/DataElementPropertyName" class="DataElementPropertyName" incremental="true">
                        <xf:label>Property:</xf:label>
                    </xf:input>
                    
                    <xf:select1 ref="instance('de')/DataElementRepresentationTerm"  incremental="true">
                        <xf:label>Representation Term:</xf:label>
                        <xf:itemset nodeset="instance('code-tables')/CodeTable[DataElementName='DataElementRepresentationTerm']/item">
                            <xf:label ref="label"/>
                            <xf:value ref="value"/>
                            <xf:hint ref="hint"/>
                        </xf:itemset>
                    </xf:select1>
                    
                    <xf:select1 ref="instance('de')/XMLSchemaDataTypeCode">
                        <xf:label>XML Schema Data Type:</xf:label>
                        <xf:itemset nodeset="instance('code-tables')/CodeTable[DataElementName='XMLSchemaDataTypeCode']/item">
                            <xf:label ref="label"/>
                            <xf:value ref="value"/>
                        </xf:itemset>
                    </xf:select1>
                </xf:group>
            </xf:group>
            
            <xf:textarea ref="instance('de')/DataElementDefinitionText" class="Definition">
                <xf:label>Definition:</xf:label>
            </xf:textarea>

            <xf:select1 ref="instance('de')/DataElementNamespaceURI">
                <xf:label>Namespace:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/CodeTable[DataElementName='NamespaceURICode']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>

            <xf:select1 ref="instance('de')/DataElementApprovalStatusCode">
                <xf:label>Approval Status:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/CodeTable[DataElementName='DataElementApprovalStatusCode']/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
            </div>
            <xf:group ref="instance('views')/enumerations-view">
                <xf:label class="group-label">Enumerated Values:</xf:label>
                <xf:group ref="instance('de')/EnumeratedValues">
                    <table border="1">
                        <thead>
                            <tr>
                                <th class="CodeID">ID</th>
                                <th class="Code">Code</th>
                                <th class="LegacyCode">DB CD</th>
                                <th class="ScreenLabelText">Screen Label</th>
                                <th class="ShortDefinitionText">Short Definition</th>
                                <th class="FullDefinitionText">Full Definition</th>
                            </tr>
                        </thead>
                    </table>
                    <xf:repeat  nodeset="instance('de')/EnumeratedValues/Value" id="value-repeat">
                    <div>
                            <span class="cell CodeID">
                                <xf:input ref="CodeID" id="code-id-input"/>
                            </span>
                            <span class="cell Code">
                                <xf:input ref="Code"/>
                            </span>
                            <span class="cell LegacyCode">
                                <xf:input ref="LegacyCode"/>
                            </span>
                            <span class="cell ScreenLabelText">
                                <xf:input ref="ScreenLabelText"/>
                            </span>
                            <span class="cell ShortDefinitionText">
                                <xf:input ref="ShortDefinitionText"/>
                            </span>
                             <span class="cell FullDefinitionText">
                                <xf:input ref="FullDefinitionText"/>
                            </span>
                                <xf:trigger>
                                   <xf:label>Delete</xf:label>
                                     <xf:delete ev:event="DOMActivate"nodeset="instance('de')/EnumeratedValues/Value[index('value-repeat')]" />
                                </xf:trigger>
                        </div>
                      </xf:repeat>
                      <xf:trigger>
                    <xf:label>Add New Code</xf:label>
                    <xf:action ev:event="DOMActivate">
                        <xf:insert nodeset="instance('de')/EnumeratedValues/Value" at="last()" position="after"/>
                        <xf:setvalue ref="instance('de')/EnumeratedValues/Value[index('value-repeat')]/CodeID" value=""/>
                        <xf:setvalue ref="instance('de')/EnumeratedValues/Value[index('value-repeat')]/Code" value=""/>
                        <xf:setvalue ref="instance('de')/EnumeratedValues/Value[index('value-repeat')]/LegacyCode" value=""/>
                        <xf:setvalue ref="instance('de')/EnumeratedValues/Value[index('value-repeat')]/ScreenLabelText" value=""/>
                        <xf:setfocus control="code-id-input"/>
                    </xf:action>
                </xf:trigger>
                </xf:group>
                
            <xf:textarea ref="instance('de')/DataElementNoteText" class="DataElementNoteText">
                <xf:label>Notes:</xf:label>
            </xf:textarea>

         </xf:group>
            
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>
        
        <xf:submit submission="echo-test">
            <xf:label>Echo Test</xf:label>
        </xf:submit>
         {style:footer()}
    </body>
</html>