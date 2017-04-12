xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $id := request:get-parameter('id', '')
let $doc := concat($data-collection, '/', $id, '.xml')
let $title :="Task Viewer"

let $task := doc($doc)/task
(: if it starts with http put in a link :)
let $depends-on := if (starts-with($task/depends-on[1]/text(), 'http'))
    then (<a href="{$task/depends-on[1]/text()}">{$task/depends-on[1]/text()}</a>)
    else ($task/resource[1]/text())
let $resource := if (starts-with($task/resource[1]/text(), 'http'))
    then (<a href="{$task/resource[1]/text()}">{$task/resource[1]/text()}</a>)
    else ($task/resource[1]/text())
    
let $content :=
<div class="content">
    {<table class="span-11">
        <thead>
           <th class="span-3">Field</th>
           <th class="span-8">Value</th>
        </thead>
        <tbody> 
       
        <tr><td class="field-label">Task Name:</td><td>{$task/task-name/text()}</td></tr>
        <tr><td class="field-label">Task Description:</td><td>{$task/task-description/text()}</td></tr>
        <tr><td class="field-label">Task Type:</td><td>{$task/task-type-code/text()}</td></tr>
        <tr><td class="field-label">Task Assigned To:</td><td>{$task/task-assigned-person/text()}</td></tr>
        <tr><td class="field-label">Task Priority:</td><td>{$task/task-priority-code/text()}</td></tr>       
        <tr><td class="field-label">Compleation Status:</td><td>{$task/task-completion-status-code/text()}</td></tr> 
        <tr><td class="field-label">Depends On:</td><td>{string-join($task/depends-on, ',')}</td></tr>
        <tr><td class="field-label">Resources:</td><td>{string-join($task/resource, ',')}</td></tr>
        </tbody>
     </table>
     }
  {style:revision-status-table($task)}
  {style:edit-controls($id)}
     

</div>

return style:assemble-page($title, $content)       
