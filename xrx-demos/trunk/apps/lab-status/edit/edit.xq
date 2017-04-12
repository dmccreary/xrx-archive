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

let $title := concat('Edit Student Record #', $id)
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
               <delete-lab-trigger/>
            </data>
        </xf:instance>
        
        <xf:bind id="delete-lab-trigger" nodeset="instance('views')/delete-lab-trigger" 
            relevant="instance('save-data')/labs/lab[2]"/> 
       
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
            instance="save-data" replace="all"/>
            
    </xf:model>
        
let $content :=
    <div class="content">
    
        <xf:submit submission="save">
           <xf:label>Save</xf:label>
        </xf:submit>
       
        <div class="block-form">
    
            { (: only display the ID if we are not creating a new item :)
            if ($id) then 
                <xf:output ref="id" class="id">
                   <xf:label>ID:</xf:label>
                </xf:output>
            else ()}
            
           <xf:input ref="user-id">
                <xf:label>User ID:</xf:label>
            </xf:input>
            
            <xf:input ref="name">
                <xf:label>user-id:</xf:label>
            </xf:input>
            
            <xf:input ref="first-name">
                <xf:label>First Name:</xf:label>
            </xf:input>
            
            <xf:input ref="last-name">
                <xf:label>Last Name:</xf:label>
            </xf:input>
          
       </div>
       
       <xf:repeat nodeset="instance('save-data')/labs/lab" id="lab-repeat">
           <!-- both on the same line -->
           <xf:input ref="./lab-id">
                <xf:label>Lab-id:</xf:label>
           </xf:input>
           <xf:input ref="./progress-percent">
                <xf:label>Progress (percent):</xf:label>
           </xf:input>

           <xf:trigger bind="delete-lab-trigger">
                   <xf:label>Delete Lab</xf:label>
                   <xf:delete nodeset="instance('save-data')/labs/lab[index('lab-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
       <xf:trigger>
            <xf:label>Add Lab</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/labs/lab" at="last()" position="after"/>
               <!-- this makes the new tag null -->
               <xf:setvalue ref="instance('save-data')/labs/lab[last()]/lab-id" value=""/>
               <xf:setvalue ref="instance('save-data')/labs/lab[last()]/progress-percent" value="'0'"/>
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
</div>
    
return style:assemble-form($title, (), $style, $model, $content, true())