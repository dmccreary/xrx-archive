xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
let $collection-path := '/db/mdr/tasks/data'
return
<html>
   <head>
      <title>Listing of Metadata Registry Tasks</title>
      {cms:import-css-tables()}
    </head>
    <body>
         {cms:header()}
       <a class="breadcrumb" href="../index.xhtml">Metadata Registry Home</a> &gt;
        <a class="breadcrumb" href="index.xhtml">Metadata Registry Tasks</a>
       <h1>Metadata Registry Tasks</h1>
       <p>All metadata tasks sorted by task priority.</p>
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
             for $task in collection($collection-path)/task
                let $id := $task/id/text()
                let $task-name := $task/task-name/text()
                let $priority := $task/task-priority-code/text()
                order by $priority
             return
           <tr>
               <td align="center"> {$priority}</td>
               <td><a href="view-single-task.xq?id={$id}">{$task-name}</a></td>
               <td align="center">{$task/ task-completion-status-code/text()}</td>  
                <td align="center">{$task/ task-assigned-person/text()}</td>          
               <td>{$task/task-description/text()}</td>
           </tr>
          }</tbody>
         </table>
         <a href="http://dlficsb501:8080/exist/rest/db/mdr/tasks/edit.xq?new=true">Create New Task</a>
    </body>
</html>
