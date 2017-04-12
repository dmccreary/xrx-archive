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
               <delete-category-trigger/>
               <delete-tag-trigger/>
            </data>
        </xf:instance>
        
        <!-- <xf:bind id="delete-category-trigger" nodeset="instance('views')/delete-category-trigger" 
            relevant="instance('save-data')/category[2]"/> -->
        
        <!-- If there is a second element, make the delete button visible. -->
        <xf:bind id="delete-tag-trigger" nodeset="instance('views')/delete-tag-trigger" 
            relevant="instance('save-data')/tag[2]"/>
        
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
            
           
            <xf:input ref="name">
                <xf:label>Name:</xf:label>
            </xf:input>
           
            <xf:textarea ref="description" class="description">
                <xf:label>Description:</xf:label>
            </xf:textarea>
           
            <xf:select1 ref="category"  class="category">
                <xf:label>Category:</xf:label>
                <xf:itemset nodeset="instance('code-tables')/code-table[name='category-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
            </xf:select1>
           
           <xf:select1 ref="status"  class="status">
           <xf:label>Pub Status:</xf:label>
                 <xf:itemset nodeset="instance('code-tables')/code-table[name='publish-status-code']/items/item">
                   <xf:label ref="label"/>
                   <xf:value ref="value"/>
                </xf:itemset>
           </xf:select1>
       
        </div> <!-- end of block form layout -->
       
       <xf:repeat nodeset="instance('save-data')/tag" id="tag-repeat">
           <!-- both on the same line -->
           <xf:input ref=".">
                <xf:label>Tag:</xf:label>
           </xf:input>
           <xf:trigger bind="delete-tag-trigger">
                   <xf:label>Delete</xf:label>
                   <xf:delete nodeset="instance('save-data')/tag[index('tag-repeat')]" ev:event="DOMActivate"/>
           </xf:trigger>
       </xf:repeat>
       
       <xf:trigger>
            <xf:label>Add Tag</xf:label>
            <xf:action ev:event="DOMActivate">
               <xf:insert nodeset="instance('save-data')/tag" at="last()" position="after"/>
               <!-- this makes the new tag null -->
               <xf:setvalue ref="instance('save-data')/tag[index('tag-repeat')]" value=""/>
               <!-- FIXME - add when XSTLForms supports this.  <xf:setfocus control="summary-input"/> -->
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