xquery version "1.0";
import module namespace svg-demo = 'http://danmccreary.com/svg-demo' at '../modules/svg-demo-module.xqm';
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := xs:integer(request:get-parameter('id', ''))
let $title := concat('View SVG Demo ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
    
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $item := collection($data-collection)/svg-demo[id/text() = $id]

let $content :=
<div class="test-data">
 <table class="span-10">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$item/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
     <tr><th class="field-label">Category:</th><td>{$item/category/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
     </tbody>
  </table>
  
   { if (false()) then
   <!--
   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
   -->
   else ()}
</div>

return svg-demo:assemble-page($id, $content, 'false', $item//jquery/text())