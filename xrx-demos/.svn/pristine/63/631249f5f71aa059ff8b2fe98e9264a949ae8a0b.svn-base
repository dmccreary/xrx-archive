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
              <th>#</th>
              <th>Sales Num</th>
              <th>Company Name</th>
              <th>Category</th>
           </tr>
        </thead>
        <tbody>{
          for $item at $count in collection($data-collection)//record
          return
             <tr>
                 <td><a href="view-item.xq?id={$count}">{$count}</a></td>
                 <td>{$item/sonum/text()}</td>
                 <td>{$item/dname/text()}</td>
                 <td>{$item/ename/text()}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)