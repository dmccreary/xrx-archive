xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'List All Current Requirements'

(: Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app (: $style:db-path-to-app :)
let $data-collection := concat($app-collection, '/data')
let $total-count := count(collection($data-collection)/Requirement)

let $content :=
<div class="content">
  <h3>{$title}</h3>
  <p>data collection = {$data-collection}</p>
  Total Count={$total-count}<br/>
  Sort by Requirement Name
    <table>
        <thead>
          <tr>
              <th>id</th>
              <th>Name</th>
              <th>Parents</th>
              <th>Description</th>
              <th>Priority</th>
              <th>Status</th>
          </tr>
     </thead>
     <tbody>{
     for $req in collection($data-collection)/Requirement
        let $id := $req/id/text()
        let $requirement-name := $req/RequirementShortName/text()
        order by $requirement-name
     return
   <tr>
      <td>{$id}</td>
      <td><a href="view-item.xq?id={$id}">{$requirement-name}</a></td>
      <td>{
           for $parent in $req/RequirementParentID/text()
           return
              <a href="view-item.xq?id={$parent}">{$parent}</a>, ' '
           }
      </td>
      <td>{
             substring($req/RequirementDescriptionText/text()[1], 1, 90)}
             {if (string-length($req/RequirementDescriptionText/text()[1]) > 90)
             then ('...') else ('.')
             }</td>
      <td>{ $req/RequirementPriorityCode/text()}</td>
      <td>{ $req/RequirementCompletionStatusCode/text()}</td>
    </tr>
       }</tbody>
     </table>
</div>

return style:assemble-page($title, $content)