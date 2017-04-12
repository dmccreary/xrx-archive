xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $id := request:get-parameter('id', '')



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
let $item := collection($data-collection)/lab[id/text() = $id]
let $name := $item/name/text()
let $title := concat('View Lab "', $name, '"')

let $content :=
<div class="content">
 <table class="span-10">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">File Name:</th><td>{util:document-name($item)}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$item/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
     
     <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
     </tbody>
  </table>
  
  <h4>Suggested Resources</h4>
  <table class="span-23">
    <thead>
       <tr>
          <th class="span-5">Resource Name</th>
          <th class="span-5">Resource Type</th>
          <th class="span-10 last">Description</th>
       </tr>
    </thead>
    <tbody>
       {for $resource in $item//resource
         return
            <tr>
               <td><a href="{$resource/url/text()}">{$resource/name/text()}</a></td>
               <td>{train:document-type-label($resource/type/text())}</td>
               <td>{$resource/description/text()}</td>
            </tr>
        }
     </tbody>
  </table>

   <!--
   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
   -->
</div>

return style:assemble-page($title, $content)