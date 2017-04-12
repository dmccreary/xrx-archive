xquery version "1.0";
import module namespace style="http://danmccreary.com/style" at "../../modules/style.xqm";


let $title :="Task Manager"
let $content :=
<div class="content">
        <ul>
            <a href="views/list-open-tasks.xq">Open Tasks</a>  A Listing of Open Tasks by Priority<br/>
            <a href="views/list-items.xq">All Tasks</a>  A listing of all tasks.<br/>
            <a href="search/search-form.xq">Search Tasks</a>  Search all tasks.<br/>
            <a href="edit/edit.xq?new=true">Create New Task</a> Create a new task.<br/>
            <a href="views/list-tasks-xml.xq">Raw XML</a> Raw XML data of all tasks used for data dumps<br/>
            <a href="views/metrics.xq">Task Metrics</a> Metrics including the counts of number of tasks<br/>
        </ul>
</div>

return style:assemble-page($title, $content)