xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace h = "http://danmccreary.com/help-manager" at "../modules/help-module.xqm";

let $title := 'List Help'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-items := doc(concat($app-collection, "/code-tables/category-codes.xml"))//item

   
return
let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Category</th>
              <th>Help Text</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/help
             let $id := $item/id/text()
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/name/text()}</td>
                 <td>{$code-table-items[./value/text() = $item/category/text()]/label/text()}</td>
                 <td>{$item/help-text/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)