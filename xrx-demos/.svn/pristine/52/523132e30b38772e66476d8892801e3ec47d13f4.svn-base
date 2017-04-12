xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View Event #', $id)

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
let $item := collection($data-collection)//event[id/text() = $id]

let $content :=
<div class="content">
 <table class="span-13">
  <thead>
       <tr>
          <th class="span-4">Field</th>
          <th class="span-9 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Location:</th><td>{$item/event-location/text()}</td></tr>
     <tr><th class="field-label">Latitude:</th><td>{$item/lat/text()}</td></tr>
     <tr><th class="field-label">Longitude:</th><td>{$item/long/text()}</td></tr>
     <tr><th class="field-label">Event Date:</th><td>{$item/event-date/text()}</td></tr>
     <tr><th class="field-label">Scale:</th><td>{$item/scale/text()}</td></tr>
     <tr><th class="field-label">Type:</th><td>{$item/Event_Type/text()}</td></tr>
     <tr><th class="field-label">Notes:</th><td>{$item/Notes/text()}</td></tr>
     <tr><th class="field-label">Short Description:</th><td>{$item/Shorter_description_for_map/text()}</td></tr>
     <tr><th class="field-label">Army:</th><td>{$item/Army/text()}</td></tr>
     <tr><th class="field-label">Report Author:</th><td>{$item/Report_Author/text()}</td></tr>
     <tr><th class="field-label">Author Rank:</th><td>{$item/Author_Rank/text()}</td></tr>
     <tr><th class="field-label">Report Date:</th><td>{$item/Report_or_Article_Date/text()}</td></tr>
     <tr><th class="field-label">Report Location:</th><td>{$item/Report_or_Article_Location/text()}</td></tr>
     <tr><th class="field-label">Report Recipient:</th><td>{$item/Report_recipient/text()}</td></tr>
     <tr><th class="field-label">Recipient Rank:</th><td>{$item/Recipient_Rank/text()}</td></tr>
     <tr><th class="field-label">Report Stored In:</th><td>{$item/Database/text()}</td></tr>
     <tr><th class="field-label">Report Citation File:</th><td>{$item/Citation__File__Series/text()}</td></tr>
     <tr><th class="field-label">Report URL:</th><td>{$item/URL/text()}</td></tr>
   </tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)