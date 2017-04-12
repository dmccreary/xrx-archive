xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

declare default element namespace "http://www.w3.org/1999/xhtml";

let $title := 'Code Table Editor'
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
    let $file := if ($new)
        then 'new-code-table.xml'
        else concat('../code-tables/', $id, '.xml')
        
let $style :=
<style type="text/css"><![CDATA[
@namespace xf url(http://www.w3.org/2002/xforms);

 .block-form xf|label {
     display: inline-block;
     width: 20ex;
     float: left;
     text-align: right;
     vertical-align: top;
     margin-right: 1ex;
     font-weight: bold;
 }

.label .xforms-value {width:40ex}
.numeric-id .xforms-value {width:10ex}
.value .xforms-value {width:40ex}

textarea {
   height: 5em;
   width: 750px !important;
}

]]></style>

let $model :=
    <xf:model>
       <xf:instance xmlns="" id="save-data" src="{$file}"/>
       <xf:bind nodeset="instance('save-data')/code-table-name" required="true()"/>
            
       <xf:submission id="save-submission" method="post"
          action="save-code-table.xq" instance="save-data" replace="all"/>
    </xf:model>

let $content :=
<div class="content">
        
        <div class="block-form">
        <xf:input ref="code-table-name" class="code-table-name">
           <xf:label>Code Table Name: </xf:label>
           <xf:hint>Use a three part name such as object-property-code where the suffix is always '-code'</xf:hint>
        </xf:input>
        <br/>
        
        <xf:textarea ref="description" class="description">
           <xf:label>Description: </xf:label>
           <xf:hint>A short, one line description of the code table.</xf:hint>
        </xf:textarea>
        <br/>
        
        <xf:input ref="data-source" class="source">
           <xf:label>Source: </xf:label>
           <xf:hint>Where did this data originate?</xf:hint>
        </xf:input>
        <br/>
        </div>
        <fieldset>
           <legend><span class="legend">Codes</span></legend>
           
           <table>
             <thead>
                <tr>
                   <th>Label</th>
                   <th>Numberic ID</th>
                   <th>Value</th>
                </tr>
             </thead>
           </table>
           
           <xf:repeat nodeset="instance('save-data')/items/item" id="item-repeat">
               <xf:input ref="label" class="label"/>
               <xf:input ref="numeric-id" class="numeric-id"/>
               <xf:input ref="value" class="value"/>
               <xf:trigger>
                  <xf:label>Delete</xf:label>
                  <xf:delete  ev:event="DOMActivate" nodeset="instance('save-data')/items/item[index('item-repeat')]"/>
               </xf:trigger>
           </xf:repeat>
           
           <xf:trigger>
                  <xf:label>Add New Code After Selected Item</xf:label>
                  <xf:action ev:event="DOMActivate">
                  <xf:insert  nodeset="instance('save-data')/items/item" at="index('item-repeat')" position="after"/>
                     <xf:setvalue ref="instance('save-data')/items/item[index('item-repeat')]/label" value="''"/>
                     <xf:setvalue ref="instance('save-data')/items/item[index('item-repeat')]/numeric-id" value="''"/>
                     <xf:setvalue ref="instance('save-data')/items/item[index('item-repeat')]/value" value="''"/>
                  </xf:action>
               </xf:trigger>
        </fieldset>
        
        <xf:submit submission="save-submission">
          <xf:label>Save</xf:label>
        </xf:submit>
        
        
        <div class="debug">
        <xf:output value="count(instance('save-data')/items/item)">
           <xf:label>Total Code Count: </xf:label>
        </xf:output>
        </div>
    
    <a href="{$file}">View XML</a>
</div>

return style:assemble-form($title, (), $style, $model, $content, true())
