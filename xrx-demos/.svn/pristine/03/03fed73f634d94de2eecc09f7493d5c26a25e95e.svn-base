xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=application/xhtml+xml indent=yes"; 

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $user := xmldb:get-current-user()
 
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

<html xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xf="http://www.w3.org/2002/xforms" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ev="http://www.w3.org/2001/xml-events" >
    <head>
       <title>Edit Requirement</title>
       {style:import-css()}
       <link type="text/css" rel="stylesheet" href="edit.css"/>
       <xf:model>
           <!-- this line loads either the new instance or the current data file into the form model -->
           <xf:instance xmlns="" src="{$file}" id="save-data"/>
           
           <xf:bind nodeset="instance('save-data')/RequirementShortName" required="true()"/>
           
           <!-- load the code tables from the code tables service -->
           <xf:instance xmlns="" id="code-tables" src="code-tables.xq"/>
            
           <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
       </xf:model>
    </head>
    <body>
    {style:header()}
    {style:breadcrumb()} &gt; <a href="../views/list-items.xq">List all Items</a>
    <h2>Edit Requirement</h2>
    <div class="block-form">
     {if ($id)
        then (
           <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
           </xf:output>
        ) else ()}
       
       <xf:input ref="RequirementShortName" class="RequirementShortName">
           <xf:label>Name:</xf:label>
           <xf:hint>Used to generate pick list of parent requirements</xf:hint>
       </xf:input>
       
       <xf:textarea ref="RequirementDescriptionText" class="RequirementDescriptionText">
           <xf:label>Description:</xf:label>
           <xf:hint>Description of the requirment and possible justification.</xf:hint>
       </xf:textarea>
       
       <xf:input ref="RequirementParentID" class="RequirementParentID">
           <xf:label>Parent ID:</xf:label>
           <xf:hint>The parent ID of this requirment</xf:hint>
       </xf:input>
       
       <xf:input ref="ProjectID" class="ProjectID">
           <xf:label>Project ID:</xf:label>
           <xf:hint>One or more project IDs that this requirement is used in.</xf:hint>
       </xf:input>
       
       <xf:select1 ref="RequirementPriorityCode"  class="RequirementPriorityCode">
          <xf:label>Priority Code:</xf:label>
          <xf:hint>Used to determine feature order</xf:hint>
            <xf:item>
              <xf:label>Very Low</xf:label>
              <xf:value>very-low</xf:value>
            </xf:item>
            <xf:item>
              <xf:label>Low</xf:label>
              <xf:value>low</xf:value>
            </xf:item>
            <xf:item>
              <xf:label>Medium</xf:label>
              <xf:value>medium</xf:value>
            </xf:item>
            <xf:item>
              <xf:label>High</xf:label>
              <xf:value>high</xf:value>
            </xf:item>
            <xf:item>
              <xf:label>Very High</xf:label>
              <xf:value>very-high</xf:value>
            </xf:item>
            <xf:item>
              <xf:label>Critical</xf:label>
              <xf:value>critical</xf:value>
            </xf:item>
       </xf:select1> 
       
       <xf:select1 ref="RequirementCompletionStatusCode">
       <xf:label>Status:</xf:label>
       <xf:hint>Used to determine what features are new, in review, approved or in development.</xf:hint>
               <xf:item>
                  <xf:label>New</xf:label>
                  <xf:value>new</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>In Review</xf:label>
                  <xf:value>in-review</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>Approved</xf:label>
                  <xf:value>approved</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>In Development</xf:label>
                  <xf:value>in-development</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>In Test</xf:label>
                  <xf:value>in-test</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>In Production</xf:label>
                  <xf:value>in-prodction</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>Removed</xf:label>
                  <xf:value>removed</xf:value>
               </xf:item>
       </xf:select1>
 
     <xf:select1 ref="RequirementTestableCode">
       <xf:label>Testability:</xf:label>
       <xf:hint>Used to determine if a requested feature is testable and should have unit or system tests.</xf:hint>
               <xf:item>
                  <xf:label>Yes Unit Testable By Developer</xf:label>
                  <xf:value>yes-unit</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>Yes System Testable By Integration Test</xf:label>
                  <xf:value>yes-system</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>No</xf:label>
                  <xf:value>false</xf:value>
               </xf:item>
               <xf:item>
                  <xf:label>Unknown</xf:label>
                  <xf:value>unknown</xf:value>
               </xf:item>
       </xf:select1>
       
        <xf:textarea ref="RequirementNoteText" class="RequirementDescriptionText">
           <xf:label>Notes:</xf:label>
           <xf:hint>Description of the requirment and possible justification.</xf:hint>
       </xf:textarea>
       
       </div>
            <xf:group>
               <xf:label class="group-label">Classifiers:</xf:label>
                  <xf:repeat id="classifier-repeat" nodeset="instance('save-data')/RequirementClassifierCode">
                     <xf:select1 ref="." class="inline-delete" id="classifier-select">
                         <xf:label>Classifier:</xf:label>
                         <xf:hint>A code for classifying all the data elements.</xf:hint>
                         <xf:itemset nodeset="instance('code-tables')/CodeTable[CodeTableName='ClassifierCode']/item">
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
    </body>
</html>
