xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Listing of SVG Demos'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Description</th>
              <th>Status</th>
              <th>Tag</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/svg-demo
             let $id := $item/id/text()
             order by number($id)
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/name/text()}</td>
                 <td>{$item/description/text()}</td>
                 <td>{$item/status/text()}</td>
                 <td>{$item/tag/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)