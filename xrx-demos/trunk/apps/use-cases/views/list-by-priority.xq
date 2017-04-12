xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
let $title := 'All Requirements Sorted by ID'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $total-count := count(collection($data-collection)/Requirement)

return

let $content :=
<div class="content">
      Total Count={$total-count}<br/>
      Sort by Requirement ID
        <table>
            <thead>
              <tr>
                  <th>id</th>
                  <th>Name</th>

                  <th>Priority</th>
                  <th>Status</th>
                  <th>Edit</th>
              </tr>
         </thead>
         <tbody>{
         for $req in collection($data-collection)/Requirement
            let $id := $req/id/text()
            let $requirement-name := $req/RequirementShortName/text()
            order by number($id)
         return
       <tr>
          <td>{$id}</td>
          <td><a href="view-item.xq?id={$id}">{$requirement-name}</a></td>

          <td>{ $req/RequirementPriorityCode/text()}</td>

          <td><a href="../edit/edit.xq?id={$id}">Edit</a></td>
        </tr>
           }</tbody>
         </table>
</div>

return style:assemble-page($title, $content)