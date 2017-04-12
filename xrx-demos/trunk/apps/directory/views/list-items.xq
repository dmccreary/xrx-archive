xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Employee Directory Listing'

let $data-collection := $style:db-path-to-app-data

let $persons := collection($data-collection)//person
let $sorted-persons :=
   for $person in $persons
      order by $person/EmployeeName/text()
      return $person
      
let $content :=
<div class="content">

<p>Listing of employees in data collection: {$data-collection}.</p>

Count = {count($persons)}<br/>
<table class="span-23">
   <thead>
      <tr>
         <th class="span-1">Ext.</th>
         <th class="span-4">Name</th>
         <th class="span-5">Title</th>
         <th class="span-2">Direct Dial</th>
         <th class="span-2">Cell</th>
         <th class="span-2">Home</th>
         <th class="span-1">State</th>
         <th class="span-3 last">E-mail</th>
      </tr>
   </thead>
   <tbody>
    {
    for $person at $count in $sorted-persons
    let $id := $person/id/text()
    let $name := $person/EmployeeName/text()
    return
       <tr> {if ($count mod 2) then (attribute bgcolor {'Lavender'}) else ()}

          <td>{$person/Extension/text()}</td>
          <td><a href="view-item.xq?id={$id}">{$name}</a></td>
          <td>{$person/Title/text()}</td>
          <td>{$person/DirectDial/text()}</td>
          <td>{$person/CellPhone/text()}</td>
          <td>{$person/Home/text()}</td>
          <td>{$person/State/text()}</td>
          <td><a href="mailto:{$person/EMail/text()}">{$person/EMail/text()}</a></td>
       </tr>
    }
   </tbody>
</table>
</div>

return
    style:assemble-page($title, $content)