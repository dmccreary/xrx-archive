xquery version "1.0";
import module namespace style="http://danmccreary.com/style" at "../../../modules/style.xqm";



let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title := 'List Feedback Items'
let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Description</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/feedback
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/description/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)