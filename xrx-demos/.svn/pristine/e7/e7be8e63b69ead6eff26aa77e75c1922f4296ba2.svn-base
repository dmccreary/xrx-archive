xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View Process ', $id)

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
let $item := collection($data-collection)/process-steps[id=$id]

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
     <tr><th class="field-label">Process Name:</th><td>{$item/process-name/text()}</td></tr>
     <tr><th class="field-label">Process Description:</th><td>{$item/process-description/text()}</td></tr>
   </tbody>
  </table>
  
 <table class="span-12">
  <thead>
       <tr>
          <th class="span-1">Step</th>
          <th class="span-3">Activity Name</th>
          <th class="span-3">Activity Code</th>
       </tr>
  </thead>
  <tbody>
     {for $activity at $count in $item//activity
      return
        <tr>
            {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
             }
             <td>{$count}</td>
             <td>{$activity/activity-name/text()}</td>
             <td>{$activity/activity-type-code/text()}</td>
     </tr>
     }
   </tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)