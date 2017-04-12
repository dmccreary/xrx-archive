xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


let $title := 'New Requirements Report'

(: Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $active-requirments := collection($data-collection)/Requirement[RequirementCompletionStatusCode = 'new']
let $total-count := count($active-requirments)

let $content :=
<div class="content">
      Total Active Requirements = {$total-count} (only requirements that have not been marked as "removed")<br/>
      Sort by Requirement Priority Rank
        <table>
                  <tr>
                  <th>id</th>
                  <th>Name</th>
                  <th>Priority</th>
                  <th>Status</th>
              </tr>
         <tbody>{
         for $req in $active-requirments
            let $id := $req/id/text()
            let $requirement-name := $req/RequirementShortName/text()
            let $requirement-priority := $req/RequirementPriorityCode/text()
            order by ($requirement-priority), $requirement-name
         return
       <tr>
          <td>{$id}</td>
          <td><a href="view-item.xq?id={$id}">{$requirement-name}</a></td>
          <td>{ $req/RequirementPriorityCode/text()}</td>      
          <td>{ $req/RequirementCompletionStatusCode/text()}</td>
        </tr>
           }</tbody>
         </table>
</div>

return style:assemble-page($title, $content)