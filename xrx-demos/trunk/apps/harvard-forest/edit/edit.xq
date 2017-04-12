xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Document namespaces declarations :)

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

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

let $title := concat('Edit ', $id)
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=', $id)

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-item.xq?id=', $id)

let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 15ex;
        }
        
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }

        .uri .xforms-value {width: 90ex;}
        .description textarea {
            height: 10ex;
            width:630px;
        }
        .note textarea {
            height: 10ex;
            width:630px;
        }
    ]]>
 </xhtml:style>

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}"/>
        
        <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
        
        <xf:instance xmlns="" id="views">
            <data>
               <delete-keyword-trigger/>
               <delete-creator-trigger/>
            </data>
        </xf:instance>
       
      <xf:instance xmlns="" id="creator-template">
      <data>
        <creator>
         <nameElement persCorp="personal"></nameElement>
         <role></role>
         <source></source>
        </creator>
      </data>
      </xf:instance>
        
        
        <!-- If there is a second element, make the delete button visible. -->
        <xf:bind id="delete-keyword-trigger" nodeset="instance('views')/delete-keyword-trigger" 
            relevant="instance('save-data')/keyword[2]"/>   
            
               <!-- If there is a second element, make the delete button visible. -->
        <xf:bind id="delete-creator-trigger" nodeset="instance('views')/delete-creator-trigger" 
            relevant="instance('save-data')/creator[2]"/>  
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
let $content :=
    <div class="content">
       
        <div class="block-form">
    
            { (: only display the ID if we are not creating a new item :)
            if ($id) then 
                <xf:output ref="recordID" class="id">
                   <xf:label>Record ID:</xf:label>
                </xf:output>
            else ()}
            
           
            <xf:input ref="title">
                <xf:label>Title:</xf:label>
            </xf:input>
          
          </div> <!-- end of block form layout -->  
          
          <xf:repeat nodeset="instance('save-data')/creator" id="creator-repeat">
           <!-- both on the same line -->
           <xf:input ref="nameElement">
                <xf:label>Creator Name:</xf:label>
           </xf:input>
           <xf:select1 ref="role">
                <xf:label>Creator Role:</xf:label>
                <xf:item>
                  <xf:label>Researcher</xf:label>
                  <xf:value>researcher</xf:value>
                </xf:item>
                <xf:item>
                  <xf:label>Student</xf:label>
                  <xf:value>student</xf:value>
                </xf:item>
                <xf:item>
                  <xf:label>Instructor</xf:label>
                  <xf:value>instructor</xf:value>
                </xf:item>
           </xf:select1>
           <xf:input ref="source">
                <xf:label>Creator Source:</xf:label>
           </xf:input>
           <xf:trigger bind="delete-creator-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="instance('save-data')/creator[index('keyword-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
       <xf:trigger>
            <xf:label>Add Creator</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert origin="instance('creator-template')/creator" at="last()" position="after"/>              
            </xf:action>
       </xf:trigger>


       <div class="block-form">
           
            <xf:textarea ref="spatialCoverage/geographicDescription" class="description">
                <xf:label>Geographic Description:</xf:label>
            </xf:textarea>
            
            <xf:input ref="workType">
                <xf:label>Work Type:</xf:label>
            </xf:input>
                  
        </div> <!-- end of block form layout -->
       
       <xf:repeat nodeset="instance('save-data')/keyword" id="keyword-repeat">
           <!-- both on the same line -->
           <xf:input id="keyword-input" ref=".">
                <xf:label>Keyword:</xf:label>
           </xf:input>
           <xf:trigger bind="delete-keyword-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="instance('save-data')/keyword[index('keyword-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
       <xf:trigger>
            <xf:label>Add Keyword</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/keyword" at="last()" position="after"/>
               <!-- this makes the new keyword null -->
               <xf:setvalue ref="instance('save-data')/keyword[last()]" value="''"/>
               
            </xf:action>
       </xf:trigger>
      
      <br/>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
              
       <xf:trigger>
         <xf:label>Cancel</xf:label>
          <xf:action ev:event="DOMActivate">
             <xf:load show="replace">
                <xf:resource value="'{$cancel}'"/>
             </xf:load>
          </xf:action>
       </xf:trigger>

            <a href="{$file}"><img src="{$style:web-path-to-site}/resources/images/xml.png" alt="View XML" height="25px"/></a>

    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())