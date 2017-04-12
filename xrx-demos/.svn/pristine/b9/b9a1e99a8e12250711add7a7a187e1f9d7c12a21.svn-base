xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Students'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $students := collection($data-collection)/student

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>User ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Labs</th>
              <th>Avg Progress</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in $students
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/user-id/text()}</td>
                 <td>{$item/first-name/text()}</td>
                 <td>{$item/last-name/text()}</td>
                 <td>{string-join($item/labs/lab/lab-id/text(), ', ')}</td>
                 <td>{avg($item/labs/lab/progress-percent/text())}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)