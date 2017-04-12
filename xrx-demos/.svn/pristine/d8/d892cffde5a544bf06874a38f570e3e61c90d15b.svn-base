xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace e = "http://www.danmccreary.com/ecology-metadata" at "../modules/eml-module.xqm";
declare namespace eml="eml://ecoinformatics.org/eml-2.1.0";

let $id := request:get-parameter('id', '')
let $title := concat('View EML Dataset ID=', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $item := e:get($id)

let $content :=
<div class="content">
 <table class="span-12">
  <thead>
       <tr>
          <th class="span-3">Field</th>
          <th class="span-9 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Title:</th><td>{$item/eml:dataset/eml:title/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
     <tr><th class="field-label">Category:</th><td>{$item/category/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
   </tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)