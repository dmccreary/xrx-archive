xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $state := request:get-parameter('state', '')

let $title := concat('Persons from the state of ', $state)

let $data-collection := $style:db-path-to-app-data

let $persons := collection($data-collection)//person[State=$state]
      
let $content :=
<div class="content">

<p>Listing of persons in data collection: {$data-collection}.</p>

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
         <th class="span-1 last">E-mail</th>
         <th class="span-1">View</th>
      </tr>
   </thead>
   <tbody>
    {
    for $person in $persons
    let $id := $person/id/text()
    let $name := $person/EmployeeName/text()
    order by $name
    return
       <tr>
          <td><a href="view-item.xq?id={$id}">{$person/Extension/text()}</a></td>
          <td>{$name}</td>
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