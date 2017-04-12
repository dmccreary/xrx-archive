xquery version "1.0";
import module namespace style="http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title := "Listing of Tasks"      

let $content :=
<div class="content">
<p>A list of all tasks regardless of their status</p>
        <table>
            <thead>
                <tr>
                   <th>Priority</th>
                   <th>Name</th>
                   <th>Status</th>
                   <th>Assigned</th>
                   <th>Description</th>
                </tr>
            </thead>
            <tbody>
            {
             for $task in collection($data-collection)/task
                let $id := $task/id/text()
                let $task-name := $task/task-name/text()
                let $priority := $task/task-priority-code/text()
                order by $priority
             return
           <tr>
               <td align="center"> {$priority}</td>
               <td><a href="view-item.xq?id={$id}">{$task-name}</a></td>
               <td align="center">{$task/ task-completion-status-code/text()}</td>  
                <td align="center">{$task/ task-assigned-person/text()}</td>          
               <td>{$task/task-description/text()}</td>
           </tr>
          }</tbody>
         </table>
         
</div>
return style:assemble-page($title, $content)       
         