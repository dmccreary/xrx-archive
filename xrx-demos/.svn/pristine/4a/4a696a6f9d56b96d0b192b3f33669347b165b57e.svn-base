xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace u = "http://danmccreary.com/user-manager" at "../modules/user-module.xqm";

let $title := 'List Users'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

return
let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Users ID</th>
              <th>Given Name</th>
              <th>Last Name</th>
              <th>Active</th>
              <th>Max Logins</th>
              <th>Roles</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/user
             let $id := $item/id/text()
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/user-id/text()}</td>
                 <td>{$item/person-given-name/text()}</td>
                 <td>{$item/person-family-name/text()}</td>
                 <td>{$item/account-active-indicator/text()}</td>
                 <td>{$item/max-login-retrys/text()}</td>
                 <td>{string-join(u:role-labels($id), ', ')}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)