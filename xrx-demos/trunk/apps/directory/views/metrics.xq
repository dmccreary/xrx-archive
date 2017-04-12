xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Person Directory Metrics'

let $data-collection := $style:db-path-to-app-data

let $persons := collection($data-collection)//person
let $person-titles := collection($data-collection)//Title/text()
let $distinct-titles := distinct-values($person-titles)
let $distinct-states := distinct-values($persons/State/text())
      
let $content :=
<div class="content">

<p>Listing of persons in data collection: {$data-collection}.</p>

States = {string-join($distinct-states, ', ')}<br/>
Count = {count($distinct-states)}<br/>
<table class="span-8">
   <thead>
      <tr>
         <th class="span-3">State</th>
         <th class="span-5">Nbr of People</th>
      </tr>
   </thead>
   <tbody>
    {
    for $state in $distinct-states
    order by $state
    return
       <tr>
          <td><a href="list-employees-from-state.xq?state={$state}">{$state}</a></td>
          <td>{count($persons[State = $state])}</td>
       </tr>
    }
   </tbody>
</table>

<table class="span-8">
  <thead>
    <tr>
        <th class="span-3">Title</th>
        <th class="span-5">Count</th>
    </tr>
    </thead>
    <tbody>
     {
     for $pers-title in $distinct-titles
     return
       <tr>
       
         <td>{$pers-title}</td>
         <td>{count($person-titles[. = $pers-title])}</td>
       </tr>
    }
    </tbody>
</table>
</div>

return
    style:assemble-page($title, $content)