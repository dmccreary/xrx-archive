xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";


(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare default element namespace "http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://exist-db.org/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

let $new := request:get-parameter('new', '')
let $id := request:get-parameter('id', '')
let $title := 'Edit Security Role'
return
(: check for required parameters :)
    if (not($new or $id)) then 
        <error>
            <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
        </error>
    else

(: proceed :)

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
    <style language="text/css">
        <![CDATA[
            @namespace xf url("http://www.w3.org/2002/xforms");
            .block-form xf|label {
                width: 15ex;
            }
            
            /* make sure the select and select1 items don't float to the left */
            xf|select xf|item, xf|select1 xf|item {
                margin-left: 16ex;
            }
            .name .xforms-value {width: 40ex;}
            .label .xforms-value {width: 60ex;}
            .description textarea {
                height: 8ex;
                width:630px;
            }
        ]]>
     </style>


let $model :=
<xf:model>
    <xf:instance id="my-security-role" src="{$file}"/>
    
    <xf:instance id="code-tables" src="all-codes.xq" xmlns=""/>
   
    <xf:submission id="save" method="post" 
    action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" instance="my-security-role" replace="all"/>
</xf:model>

let $content :=
    <div class="content">
     
       <div class="block-form">
       
       {if ($new ne 'true') then 
          <xf:output ref="id"><xf:label>ID:</xf:label>{$id}</xf:output> else ()}
       
        <xf:input ref="name" class="name">
            <xf:label>Role Name:</xf:label>
            <xf:hint>The name of a security-role up to 30 characters lowercase and dashes only.</xf:hint>
        </xf:input>
        
       <xf:input ref="label" class="name">
            <xf:label>Label:</xf:label>
            <xf:hint>The Label of a security-role up to 50 characters.  Can include spaces and upper case.</xf:hint>
        </xf:input>
        
        <xf:textarea ref="description" class="description" >
            <xf:label>Description:</xf:label>
        </xf:textarea>

        <xf:select1 ref="instance('my-security-role')/category">
            <xf:label>Role Location:</xf:label><br/>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='role-location-code']/items/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
                <xf:hint>The location that this security role applies such as intranet or public web site.</xf:hint>
        </xf:select1>

        <xf:select1 ref="instance('my-security-role')/status">
            <xf:label>Status:</xf:label>
            <xf:itemset nodeset="instance('code-tables')/code-table[name='role-status-code']/items/item">
                    <xf:label ref="label"/>
                    <xf:value ref="value"/>
                </xf:itemset>
            <xf:hint>The workflow status of this role in the development process.</xf:hint>
        </xf:select1>
    </div>
       
        <br/>
        <xf:submit submission="save">
            <xf:label>Save</xf:label>
        </xf:submit>
        
    </div>


return style:assemble-form($title, (), (), $model, $content, true())