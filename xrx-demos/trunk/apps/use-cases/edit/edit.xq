xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title := 'User Story Editor'
 
return
(: check for required parameters :)
if (not($new or $id))
    then (
    <error>
        <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/data')

     (: put in the appropriate file name :)
     let $file := 
        if ($new)
           then ('new-instance.xml')
           else concat('get-instance.xq?id=', $id)

let $style :=
<style type="text/css">
       <![CDATA[
       testarea { 
                height: 4em;
                width: 950px;
           }
           
           .UseCaseGoalText .xforms-value,
           .UseCaseSummaryText .xforms-value,
           .UseCasePreconditionsText .xforms-value,
           .UseCaseTriggersText .xforms-value,
           .UseCaseEventsText .xforms-value,
           .UseCaseAlternatePathsText .xforms-value,
           .UseCasePostconditionsText .xforms-value,
           .BusinessRulesText .xforms-value,
           .UseCaseNotesText .xforms-value
           { 
                height: 4em;
                width: 950px;
           }
       ]]>
       </style>
       
let $model :=
<xf:model>
   <!-- this line loads either the new instance or the current data file into the form model -->
   <xf:instance xmlns="" src="{$file}" id="save-data"/>
   
    <xf:bind nodeset="instance('save-data')/UseCaseName" required="true()"/>
    <xf:bind nodeset="instance('save-data')/UseCaseGoalText" required="true()"/>

   <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-task" replace="all"/>
</xf:model>

let $content :=
<div class="content">
    
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
    
        <xf:input ref="UseCaseName" class="UseCaseName">
            <xf:label>UseCaseName : </xf:label>
        </xf:input>
        
        <xf:input ref="UseCaseVersion" class="UseCaseVersion">
            <xf:label>Version:</xf:label>
        </xf:input>
        
        <xf:textarea ref="UseCaseGoalText" class="UseCaseGoalText">
            <xf:label>Goal: </xf:label>
        </xf:textarea>
        
        <xf:textarea ref="UseCaseSummaryText" class="UseCaseSummaryText">
            <xf:label>Summary: </xf:label>
        </xf:textarea>
        
        <xf:input ref="UseCaseActor" class="UseCaseActor">
            <xf:label>Actor:</xf:label>
        </xf:input>

        <xf:textarea ref="UseCasePreconditionsText" class="UseCasePreconditionsText">
            <xf:label>Preconditions:</xf:label>
        </xf:textarea>
        
        <xf:textarea ref="UseCaseTriggersText" class="UseCaseTriggersText">
            <xf:label>Triggers:</xf:label>
        </xf:textarea>
               
        <xf:textarea ref="UseCaseEventsText" class="UseCaseEventsText">
            <xf:label>Events: </xf:label>
        </xf:textarea>
        
        <xf:textarea ref="UseCaseAlternatePathsText" class="UseCaseAlternatePathsText">
            <xf:label>Alternate Paths: </xf:label>
        </xf:textarea>

        <xf:textarea ref="UseCasePostconditionsText" class="UseCasePostconditionsText">
            <xf:label>Postconditions: </xf:label>
        </xf:textarea>

        
        <xf:textarea ref="BusinessRulesText" class="BusinessRulesText">
            <xf:label>Business Rules: </xf:label>
        </xf:textarea>
               
        <xf:textarea ref="UseCaseNotesText" class="UseCaseNotesText">
            <xf:label>Notes Text: </xf:label>
        </xf:textarea>
        
        <xf:input ref="UseCaseAuthorName" class="UseCaseAuthorName">
            <xf:label>Author Name: </xf:label>
        </xf:input>

        <xf:input ref="UseCaseCreationDate" class="UseCaseCreationDate">
            <xf:label>Creation Date: </xf:label>
        </xf:input>
        
        </div>
        
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>

    </div>
 
return style:assemble-form($title, (), $style, $model, $content, false())