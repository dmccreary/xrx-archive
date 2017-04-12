xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Title</th>
              <th>Geographic Description</th>
              <th>Work Type</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item at $count in collection($data-collection)/archiveFile
             let $id := $item/recordID/text()
             order by $id
          return
             <tr>
                 {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
                 }
                 <td>{$id}</td>
                 <td>{$item/title/text()}</td>
                 <td>{$item//geographicDescription[1]/text()}</td>
                 <td>{$item/workType/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)