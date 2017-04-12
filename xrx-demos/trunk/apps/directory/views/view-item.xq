xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'View Employee Record'

let $id := request:get-parameter('id', '')
(: check for required parameters :)
return
   if (not($id)) then <error><message>Error - missing required parameter: id</message></error> else

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $item := collection($data-collection)/person[id = $id]
let $person := collection($data-collection)//person[id/text() = $id]

let $content :=
<div class="content">

<b>Record ID: </b> {$id}<br/>

<table class="span-12 last">
  <thead>
     <tr>
        <th class="span-4">Field</th>
        <th class="span-8">Value</th>
     </tr>
  </thead>
  <tbody>
    <tr>
       <th class="field-label">Extension:</th>
       <td>{$person/Extension/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Name:</th>
       <td>{$person/EmployeeName/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Title:</th>       
       <td>{$person/Title/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Direct Dial:</th>
       <td>{$person/DirectDial/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Cell:</th>
       <td>{$person/CellPhone/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Home:</th>
       <td>{$person/Home/text()}</td>
    </tr>
    <tr>
       <th class="field-label">State:</th>
       <td>{$person/State/text()}</td>
    </tr>
    <tr>
       <th class="field-label">Email:</th>
       <td><a href="mailto:{$person/EMail/text()}">{$person/EMail/text()}</a></td>
    </tr>
   </tbody>
</table>

    {style:revision-status-table($item)}
    {style:edit-controls($id)}
    
</div>

return style:assemble-page($title, $content)

