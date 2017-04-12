xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace e = "http://www.danmccreary.com/ecology-metadata" at "../modules/eml-module.xqm";
declare namespace eml="eml://ecoinformatics.org/eml-2.1.0";

let $title := 'List EML Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

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
          for $item at $count in collection($data-collection)/eml:eml
             let $id := $item/dataset/@id/string()
             order by $id
          return
             <tr>
                 {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
                 }
                 <td>{$id}</td>
                 <td>{$item//title/text()}</td>
                 <td>{$item/category/text()}</td>
                 <td>{$item/status/text()}</td>
                 <td>{$item/tag/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)