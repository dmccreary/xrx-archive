xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


let $title := 'Requirements Approval Report'

(: Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $active-requirments := collection($data-collection)/Requirement[RequirementCompletionStatusCode != 'removed']
let $total-count := count($active-requirments)
return

let $content :=
<div class="content">
    Total Active Requirements = {$total-count} (only requirements that have not been marked as "removed")<br/>
    Sort by Requirement Priority Rank
    <table>
        <thead>
          <tr>
              <th>id</th>
              <th>Name</th>
              <th>Priority</th>
              <th>Arch. Sig.</th>
              <th>Status</th>
              <th>Approved By</th>
              <th>Approval Date</th>
              <th>View</th>
              <th>Edit</th>
          </tr>
     </thead>
     <tbody>{
     for $req in $active-requirments
        let $id := $req/id/text()
        let $requirement-name := $req/RequirementShortName/text()
        let $requirement-priority := $req/RequirementPriorityCode/text()
        order by $requirement-priority, $requirement-name
     return
    <tr>
      <td>{$id}</td>
      <td><a href="view-item.xq?id={$id}">{$requirement-name}</a></td>
      <td>{ $req/RequirementPriorityCode/text()}</td>
      <td align="center">{ $req/RequirementLevelCode/text()}</td>
      <td align="center">{ $req/RequirementCompletionStatusCode/text()}</td>
      <td align="center">{ $req/RequirementApprovedBy/text()}</td>
      <td align="center">{ $req/RequirementApprovalDate/text()}</td>
      <td><a href="view-item.xq?id={$id}">View</a></td>
      <td><a href="../edit/edit.xq?id={$id}">Edit</a></td>
    </tr>
       }</tbody>
     </table>
 </div>
return style:assemble-page($title, $content)