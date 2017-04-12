xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';


let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $user := request:get-parameter('user', xmldb:get-current-user())
let $options := request:get-parameter('options', '')

let $projects :=
 collection($data-collection)/GeneralProject

let $title :='List Projects'

let $content :=
<div class="content">

 
   <table>
       <thead>
       <tr>
          <th>ID</th>
          <th>Project Name</th>
          <th>Project Scope</th>
          <th>Proj Mgr</th>
          <th>Status</th>
          <th>View</th>
        </tr>
    </thead>
     <tbody>{
          for $item in $projects
             let $id := $item/id/text()
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/ProjectName/text()}</td>
                 <td>{$item/ProjectScopeText/text()}</td>
                 <td>{$item/PersonRoles/Role[PersonRoleCode='pm']/UserID/text()}</td>
                 <td>{$item/DevelopmentStatusCode/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
</div>
return style:assemble-page($title, $content)
