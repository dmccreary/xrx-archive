xquery version "1.0";

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

(: Default function and element declarations :)
declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare namespace html="http://www.w3.org/1999/xhtml";

(: Document namespaces declarations :)
declare namespace hist="http://history.state.gov/ns/1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";

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
let $code-table-collection := concat($app-collection, '/code-tables')
let $data-collection := $style:db-path-to-app-data

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=',$id)

let $cancel :=
   if ($new)
      then '../'
      else  concat('../views/view-item?id=', $id)

let $style :=
    <html:style language="text/css">
        <![CDATA[
            @namespace xf url("http://www.w3.org/2002/xforms");
            .block-form xf|label {
                width: 25ex;
            }
            /* make sure the select and select1 items don't float to the left */
            xf|select xf|item {
                margin-left: 11ex;
            }
            xf|select1 xf|item {
                margin-left: 29ex;
            }
            .visitor .xforms-value {width: 45ex;}
            .from .xforms-value {width: 45ex;}

            .description textarea {
                height: 10ex;
                width:630px;
            }
            .note textarea {
                height: 10ex;
                width:630px;
            }
            fieldset legend {
                font-weight: bold;
            }
        ]]>
     </html:style>

let $model :=
<xf:model>
    <xf:instance id="save-data" src="{$file}"/>
    
    <xf:instance id="code-tables" src="all-codes"/>
      
    <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new') else ('update')}" 
        instance="save-data" replace="all"/>
        
     <xf:action ev:event="xforms-ready">
         <xf:setvalue ref="last-modified-by" value="'{xmldb:get-current-user()}'"/>
     </xf:action>     
      
</xf:model>
        
let $content :=
    <div>
        <div class="block-form">
    
        {
        if ($id) then 
            <xf:output ref="id" class="id">
               <xf:label>ID:</xf:label>
            </xf:output>
        else ()
        }
        
       {
        <xf:input ref="name">
            <xf:label>Name:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="acronym">
            <xf:label>Acronym:</xf:label>
        </xf:input>
        } 
        {
        <xf:textarea ref="definition" class="description">
             <xf:label>Definition:</xf:label>
        </xf:textarea>
        }
        {
        <xf:input ref="broader-term-id">
            <xf:label>Broader Term ID:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="wikipedia-name">
            <xf:label>Wikipedia Name:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="approval-status-code">
            <xf:label>Approval Status Code:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="classifier-code">
            <xf:label>Classifier Code:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="tag">
            <xf:label>Tag:</xf:label>
        </xf:input>
        }
        {
        <xf:input ref="author-code">
            <xf:label>Author Code:</xf:label>
        </xf:input>
        }
        
         {style:revision-status($id)}
       
       </div>
       
       <xf:submit submission="save">
           <xf:label>Save</xf:label>
       </xf:submit>
        
       {
       if ($new='true' ) then  
            <a href="new-instance.xml"><img src="{$style:web-path-to-site}/resources/images/xml.png" alt="View XML" height="25px"/></a>
          
       else 
            <a href="{$file}"><img src="{$style:web-path-to-site}/resources/images/xml.png" alt="View XML" height="25px"/></a>
       }
    </div>
 
 let $dummy-attributes := ( attribute xml:dummy {"dummy"} )
 
return style:assemble-form($dummy-attributes, $style, $model, $content)