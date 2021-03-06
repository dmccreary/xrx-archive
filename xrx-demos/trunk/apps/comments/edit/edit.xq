xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $new := request:get-parameter('new', '')
let $uri := request:get-parameter('uri', '')
let $id := request:get-parameter('id', '')
let $admin := request:get-parameter('admin', 'false')

return
(: check for required parameters :)
    if (not($new or $id)) then 
        <error>
            <message>Parameter "new" and "id" are both missing.  One of these two arguments is required for form.</message>
        </error>
    else

(: proceed :)

let $title := concat('Edit Comment #', $id)
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

(: put in the appropriate file name :)
let $file := 
    if ($new) then 
        'new-instance.xml'
    else 
        concat('get-instance.xq?id=', $id)

let $model :=
<xf:model>
    <xf:instance xmlns="" id="save-data" src="{$file}"/>
    <xf:submission id="save" method="post" action="{if ($new='true') then ('save-new.xq') else ('update.xq')}" 
        instance="save-data" replace="all"/>
</xf:model>
        
let $content :=
<div class="content">
      <div class="block-form">
      <xf:legend>Comment:</xf:legend>
        <xf:textarea ref="instance('save-data')/description" class="description"/>            
    </div> <!-- end of block form layout -->
    
    {style:revision-status($id)}
   <xf:submit submission="save">
       <xf:label>Save</xf:label>
   </xf:submit>
</div>

   
    
return style:assemble-form($title, (), (), $model, $content, true())