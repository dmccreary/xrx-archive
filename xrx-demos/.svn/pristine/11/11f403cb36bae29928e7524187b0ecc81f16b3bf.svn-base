xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $title := 'Requirements Editor'
let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
    if (not($new or $id)) then 
        <error>
            <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
        </error>
    else
    
 

(: proceed :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('../views/get-instance.xq?id=', $id)

(: check for complex content :)
let $file-path := 
   if ($id)
     then concat($data-collection, '/', $id, '.xml') 
     else concat($app-collection, '/edit', $file) 

let $requirement := doc($file-path)/Requirement

let $node-count := count($requirement/RequirementDescriptionText//node())

return
   if ($node-count gt 1)
   then
    <error>
       <message>Invalid ID.  The incomming data has complex description.  Use oXygen to edit this item.</message>
       <url>/exit/rest{substring-after($data-collection, 'xmldb:exist://')}/{$id}.xml</url>
    </error>
   else   

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-item?id=', $id)

let $model :=
<xf:model>
    <!-- this line loads either the new instance or the current data file into the form model -->
    <xf:instance xmlns="" src="{$file}" id="save-data"/>
    
    <xf:bind nodeset="instance('save-data')/name" required="true()"/>
    
    <!-- load the code tables from the code tables service -->
    <xf:instance xmlns="" id="code-tables" src="code-tables.xq"/>
    
    <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
</xf:model>

let $style :=
<xhtml:style language="text/css">
<![CDATA[
    @namespace xf url("http://www.w3.org/2002/xforms");
    .block-form xf|label {
        width: 20ex;
    }
    
    /* make sure the select and select1 items don't float to the left */
    xf|select xf|item, xf|select1 xf|item {
        margin-left: 16ex;
    }
    
    .RequirementShortName .xforms-value { 
         width: 50ex;
    }

    .uri .xforms-value {width: 90ex;}
    .RequirementDescriptionText textarea {
        height: 10ex;
        width:700px;
    }
    .RequirementNoteText textarea {
        height: 10ex;
        width:700px;
    }
    
    .RequirementEstimatedDevelopmentDays .xf-value { 
     width: 10ex;
     }

    fieldset legend {
        font-weight: bold;
    }
]]>
</xhtml:style>
       
let $content :=
<div class="content">
    <h2>Edit Requirement</h2>
    
    <xf:submit submission="save">
       <xf:label>Save</xf:label>
    </xf:submit>

    <div class="block-form">
     {if ($id)
        then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
       
       <xf:input ref="RequirementShortName" class="RequirementShortName">
           <xf:label>Name:</xf:label>
           <xf:hint>Requirement Name Under 50 characters.</xf:hint>
       </xf:input>
       
       <xf:textarea ref="RequirementDescriptionText" class="RequirementDescriptionText">
           <xf:label>Description:</xf:label>
           <xf:hint>Description of the requirment and possible justification.</xf:hint>
       </xf:textarea>
       
       <xf:select1 ref="RequirementParentID">
       <xf:label>Parent Requirement:</xf:label>
       <xf:hint>The parent ID of this requirment</xf:hint>
          <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementNameCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
          </xf:itemset>
       </xf:select1>
       
       <!-- Right now we only have a single project.  Put a selection list if we get more.
       <xf:input ref="ProjectID" class="ProjectID">
           <xf:label>Project ID:</xf:label>
           <xf:hint>One or more project IDs that this requirement is used in.</xf:hint>
       </xf:input>
       -->
      
       
       <xf:select1 ref="RequirementRequestedBy">
             <xf:label>Requested By:</xf:label>
             <xf:hint>Who requested this feature.</xf:hint>
             <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='StaffCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
             </xf:itemset>
        </xf:select1>
        
        <xf:select1 ref="RequirementApprovedBy">
             <xf:label>Approved By:</xf:label>
             <xf:hint>Who approved this feature.</xf:hint>
             <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='StaffCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
             </xf:itemset>
        </xf:select1>
       
       <xf:select1 ref="RequirementPriorityCode">
          <xf:label>Priority Code:</xf:label>
          <xf:hint>Used to determine feature order</xf:hint>
          <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementPriorityCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
          </xf:itemset>
       </xf:select1> 
       
       <xf:select1 ref="RequirementCompletionStatusCode">
       <xf:label>Completion Status:</xf:label>
       <xf:hint>How far along in the development lifecycle is this feature.</xf:hint>
           <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementCompletionStatusCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
          </xf:itemset>
       </xf:select1>
 
     <xf:select1 ref="RequirementTestableCode">
       <xf:label>Testability:</xf:label>
       <xf:hint>Used to determine if a requested feature is testable and should have unit or system tests.</xf:hint>
          <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementTestableCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
          </xf:itemset>
       </xf:select1>
       
        <xf:input ref="RequirementEstimatedDevelopmentDays" class="RequirementEstimatedDevelopmentDays">
           <xf:label>Development Days:</xf:label>
           <xf:hint>Estimated number of developer days after requirments are finalized.</xf:hint>
       </xf:input>
       
       <xf:input ref="RequirementCostEstimateAmount" class="RequirementCostEstimateAmount">
           <xf:label>Cost Estimate:</xf:label>
           <xf:hint>Cost Estimate.</xf:hint>
       </xf:input>
       
       <xf:input ref="RequirementCompletionPercent" class="RequirementCompletionPercent">
           <xf:label>Percent Complete:</xf:label>
           <xf:hint>Percent Complete in a number from 1 to 100.</xf:hint>
       </xf:input>
       
        <xf:input ref="RequirementCertaintyLevel" class="RequirementCertaintyLevel">
           <xf:label>Certainty Level:</xf:label>
           <xf:hint>Certainty Level as a decimal from 0 to 1</xf:hint>
       </xf:input>
       
       <xf:select1 ref="RequirementReleaseCode">
          <xf:label>Target Release:</xf:label>
          <xf:hint>What release is this feature targeted.</xf:hint>
          <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementReleaseCode']/items/item">
                 <xf:label ref="label"/>
                 <xf:value ref="value"/>
          </xf:itemset>
       </xf:select1>

       <xf:textarea ref="RequirementNoteText" class="RequirementDescriptionText">
           <xf:label>Notes:</xf:label>
           <xf:hint>Description of the requirment and possible justification.</xf:hint>
       </xf:textarea>
       
       </div>
       
       <xf:group>
               <xf:label class="group-label">Dependancies:</xf:label>
                  <xf:repeat id="dependancy-repeat" nodeset="instance('save-data')/RequirementDepends">
                     <xf:select1 ref=".">
                         <xf:label>Requirement:</xf:label>
                         <xf:hint>What item this requirement depends on.</xf:hint>
                         <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='RequirementNameCode']/items/item">
                             <xf:label ref="label"/>
                             <xf:value ref="value"/>
                         </xf:itemset>
                     </xf:select1>
                     <xf:trigger class="inline-delete">
                         <xf:label>Delete</xf:label>
                         <xf:delete nodeset="instance('save-data')/RequirementDepends[index('dependancy-repeat')]" ev:event="DOMActivate"/>
                     </xf:trigger>
                 </xf:repeat>
                 <xf:trigger>
                     <xf:label>Add</xf:label>
                     <xf:action ev:event="DOMActivate">
                         <xf:insert nodeset="instance('save-data')/RequirementDepends" at="last()" position="after"/>
                         <xf:setvalue ref="instance('save-data')/RequirementDepends[index('dependancy-repeat')]" value=""/>
                     </xf:action>
                 </xf:trigger>
           </xf:group>
 
            <xf:group>
               <xf:label class="group-label">Classifiers:</xf:label>
                  <xf:repeat id="classifier-repeat" nodeset="instance('save-data')/RequirementClassifierCode">
                     <xf:select1 ref="." class="inline-delete" id="classifier-select">
                         <xf:label>Classifier:</xf:label>
                         <xf:hint>A code for classifying each requirment using one or more classification schemes.</xf:hint>
                         <xf:itemset nodeset="instance('code-tables')/code-table[code-table-name='ClassifierCode']/items/item">
                             <xf:label ref="label"/>
                             <xf:value ref="value"/>
                         </xf:itemset>
                     </xf:select1>
                     <xf:trigger class="inline-delete">
                         <xf:label>Delete</xf:label>
                         <xf:delete nodeset="instance('save-data')/RequirementClassifierCode[index('classifier-repeat')]" ev:event="DOMActivate"/>
                     </xf:trigger>
                 </xf:repeat>
                     <xf:trigger>
                         <xf:label>Add</xf:label>
                         <xf:action ev:event="DOMActivate">
                             <xf:insert nodeset="instance('save-data')/RequirementClassifierCode" at="last()" position="after"/>
                             <xf:setvalue ref="instance('save-data')/RequirementClassifierCode[index('classifier-repeat')]" value=""/>
                             <xf:setfocus control="classifier-select"/>
                         </xf:action>
                     </xf:trigger>
           </xf:group>
 
           <xf:group>
              <xf:label class="group-label">Tags:</xf:label>
              <xf:repeat id="tag-repeat" nodeset="instance('save-data')/RequirementTag">
                     <xf:input ref="." class="Tag inline-delete" id="tag-input">
                         <xf:label>Tag:</xf:label>
                     </xf:input>
                     <xf:trigger class="inline-delete">
                         <xf:label>Delete</xf:label>
                         <xf:delete nodeset="instance('my-term')/RequirementTag[index('tag-repeat')]" ev:event="DOMActivate"/>
                     </xf:trigger>
               </xf:repeat>
               <xf:trigger>
                     <xf:label>Add</xf:label>
                     <xf:action ev:event="DOMActivate">
                         <xf:insert nodeset="instance('save-data')/RequirementTag" at="last()" position="after"/>
                         <xf:setvalue ref="instance('save-data')/RequirementTag[index('tag-repeat')]" value=""/>
                         <xf:setfocus control="tag-input"/>
                     </xf:action>
                 </xf:trigger>
            </xf:group>
            
           
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
</div>

return style:assemble-form($title, (), $style, $model, $content, true())