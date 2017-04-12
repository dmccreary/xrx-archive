xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Books'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $books := collection($data-collection)//book

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>Title</th>
              <th>Format</th>
              <th>License</th>
              <th>List Price</th>
           </tr>
        </thead>
        <tbody>{
          for $item in $books
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td><a href="view-item.xq?id={$id}">{$item/title/text()}</a> ({$id})</td>
                 <td>{$item/format/text()}</td>
                 <td>{$item/license/text()}</td>
                 <td>{if (string-length($item/list-price/text()) gt 1)
                         then $item/list-price/text()
                         else 'free'}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)