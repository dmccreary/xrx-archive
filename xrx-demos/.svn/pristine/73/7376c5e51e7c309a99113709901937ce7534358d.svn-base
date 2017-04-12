xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table class="span-16">
           <thead>
           <tr>
              <th>ID</th>
              <th>Process Name</th>
              <th>Description</th>
              <th>Steps</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/process-steps
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/process-name/text()}</td>
                 <td>{$item/process-description/text()}</td>
                 <td>{count($item//activity)}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)