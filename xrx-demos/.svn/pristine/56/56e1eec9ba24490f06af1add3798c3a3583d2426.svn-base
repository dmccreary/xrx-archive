xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $queue := collection($data-collection)/queue/id

let $content :=
<div class="content">
<h4>View Queue</h4>
       <table class="span-8">
           <thead>
           <tr>
              <th class="span-1">Position</th>
              <th class="span-4">Name (ID)</th>
              <th class="span-1 last">View</th>
           </tr>
        </thead>
        <tbody>{
          for $id at $count in $queue
             let $item := collection($data-collection)/item[id=$id/text()]
             order by $id
          return
             <tr>
                 <td>{$count}</td>
                 <td>{$item/name/text()} [{$id}]</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
       
       <a href="../edit/edit-queue.xq">Edit Queue</a>
  
</div>

return style:assemble-page($title, $content)