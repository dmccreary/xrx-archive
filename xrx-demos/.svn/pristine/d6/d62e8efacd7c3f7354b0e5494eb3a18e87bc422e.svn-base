xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View item ', $id)

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
let $item := collection($data-collection)/archiveFile[recordID/text() = $id]

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
     <tr><th class="field-label">ID:</th><td>{$item/recordID/text()}</td></tr>
     <tr><th class="field-label">Title:</th><td>{$item/title/text()}</td></tr>
     <tr><th class="field-label">Geographic Description:</th><td>{$item//geographicDescription/text()}</td></tr>
     
     {for $keyword in $item//keyword
     return
       <tr><th class="field-label">Keyword:</th><td>{$keyword/text()}</td></tr>
       }
       
     <tr><th class="field-label">Work Type:</th><td>{$item/workType/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
   </tbody>
  </table>
  {style:edit-controls($id, 'edv' )}
</div>

return style:assemble-page($title, $content)