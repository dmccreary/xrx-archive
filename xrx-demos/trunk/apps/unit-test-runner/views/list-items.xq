xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace kert = "http://kuberam.ro/ns/kert";
declare default element namespace "http://kuberam.ro/ns/kert";

let $title := 'List Unit Tests'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $unit-tests := collection($data-collection)//kert:test

let $content :=
<div class="content">
Count = {count($unit-tests)}
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Description</th>
              <th>Development Status</th>
              <th>Time</th>
              <th>View XML</th>
              <th>Run</th>
           </tr>
        </thead>
        <tbody>{
          for $item in $unit-tests
             let $id := $item/@id/string()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td><a href="view-item.xq?id={$id}">{$item/kert:name/text()}</a></td>
                 <td>{$item/kert:description/text()}</td>
                 <td>{$item/development-status/text()}</td>
                 <td>{$item/tag/text()}</td>
                 <td>View XML</td>
                 <td>Run</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)