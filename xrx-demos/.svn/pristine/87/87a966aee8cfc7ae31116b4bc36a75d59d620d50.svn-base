xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace xfm = "http://danmccreary.com/xforms" at "../../../modules/xforms.xqm";

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

let $title := concat('Edit Topic ', $id)
let $app-collection := $style:db-path-to-app

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance-topic.xml'
    else 
        concat('get-instance-topic.xq?id=', $id)

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-topic.xq?id=', $id)

let $style :=
<xhtml:style language="text/css">
    <![CDATA[
        @namespace xf url("http://www.w3.org/2002/xforms");
        .block-form xf|label {
            width: 15ex;
        }
        
        .name .xforms-value {width: 40ex;}
        /* make sure the select and select1 items don't float to the left */
        xf|select xf|item, xf|select1 xf|item {
            margin-left: 16ex;
        }

        .description textarea {
            height: 10ex;
            width: 800px;
        }
        .note textarea {
            height: 10ex;
            width:730px;
        }
    ]]>
 </xhtml:style>

let $model :=
    <xf:model>
        <xf:instance id="save-data" src="{$file}"/>
        <xf:instance id="code-tables" src="all-codes-topic.xq"/>
        
        <xf:instance xmlns="" id="views">
            <data>
               <delete-category-trigger/>
               <delete-tag-trigger/>
            </data>
        </xf:instance>
        
        <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new-topic.xq') else ('update-topic.xq')}" 
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
            
           
            <xf:input ref="name" class="name">
                <xf:label>Name:</xf:label>
            </xf:input>
            
            <xf:input ref="length" class="length">
                <xf:label>Length (minutes):</xf:label>
                <xf:hint>Typical length of this topic in minutes.</xf:hint>
            </xf:input>
           
            <xf:textarea ref="description" class="description">
                <xf:label>Description:</xf:label>
            </xf:textarea>
           
        </div> <!-- end of block form layout -->
       {xfm:resources()}
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
       
    </div>
    
return style:assemble-form($title, (), $style, $model, $content, true())