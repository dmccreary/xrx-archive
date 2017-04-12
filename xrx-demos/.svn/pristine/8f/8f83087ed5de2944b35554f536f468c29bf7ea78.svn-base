xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Iinput Files'

let $app-collection := $style:db-path-to-app
let $input-collection := concat($app-collection, '/input-zips')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Category</th>
              <th>Status</th>
              <th>Tag</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $id in xmldb:get-child-resources($input-collection)
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 
                 <td><a href="../scripts/unzip.xq?id={$id}&amp;action=unzip">Unzip</a></td>
                 <td><a href="../scripts/unzip.xq?id={$id}&amp;action=list">List</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)