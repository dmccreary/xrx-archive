xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace kert = "http://kuberam.ro/ns/kert";
declare default element namespace "http://kuberam.ro/ns/kert";

let $id := request:get-parameter('id', '')
let $title := concat('View Unit Test ', $id)



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
let $item := collection($data-collection)//test[string(@id) = $id]

let $content :=
<div class="content">
 <table class="span-24">
  <thead>
       <tr>
          <th class="span-3">Field</th>
          <th class="span-21 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$item/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
     <tr><th class="field-label">Unit URL:</th><td>{$item/unit-url/text()}</td></tr>
     <tr><th class="field-label">Source URL:</th><td>{$item/source-url/text()}</td></tr>
     <tr><th class="field-label">Evaluation:</th><td>{$item/evaluation/text()}</td></tr>
     <tr><th class="field-label">Timeout:</th><td>{$item/timeout/text()}</td></tr>
     <tr><th class="field-label">Development Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Log:</th><td>{$item/log/text()}</td></tr>
   </tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)