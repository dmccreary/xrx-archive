xquery version "1.0";
import module namespace style="http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $title :="Open Tasks in Order of Priority"
let $content :=
<div class="content">
  <p>All open metadata tasks sorted by task priority.  Open tasks are task marked as new, assigned or reopened.</p>
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
             for $task in collection($data-collection)/task[task-completion-status-code='new' or task-completion-status-code='assigned' or task-completion-status-code='reopened']
                let $id := $task/id/text()
                let $task-name := $task/task-name/text()
                let $priority := $task/task-priority-code/text()
                order by $priority
             return
           <tr>
               <td align="center"> {$priority}</td>
               <td><a href="view-item.xq?id={$id}">{$task-name}</a></td>
               <td align="center">{$task/task-completion-status-code/text()}</td>  
               <td align="center">{$task/task-assigned-person/text()}</td>          
               <td>{$task/task-description/text()}</td>
           </tr>
          }</tbody>
   </table>
   </div>
   
return style:assemble-page($title, $content)  
        