xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

return
<code-tables>
   {doc(concat($code-table-collection, '/task-assigned-to-code.xml'))/code-table}
   {doc(concat($code-table-collection, '/task-completion-status-code.xml'))/code-table}
   {doc(concat($code-table-collection, '/task-priority-code.xml'))/code-table}
   {doc(concat($code-table-collection, '/task-type-code.xml'))/code-table}
</code-tables>