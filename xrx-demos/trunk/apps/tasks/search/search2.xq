xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')
let $title :='Task Search Results'
return

let $content :=
<div class="content">
       <p>All tasks sorted by task priority.</p>
        <ol>{
         for $task in collection($data-collection)/task[contains/text() &= $q]
            let $id := $task/id/text()
            let $task-name := $task/task-name/text()
            let $priority := $task/task-priority-code/text()
            order by $priority
         return
       <li> {$priority} - <a href="../views/view-item.xq?id={$id}">{$task-name}</a> - {$task/task-description/text()}</li>
      }</ol>
</div>

return style:assemble-page($title, $content)  



xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title :='Search Tasks'
let $model :=
    <xf:model>
        <xf:instance xmlns="">
            <data>
                <q/>
            </data>
        </xf:instance>
       <!-- this puts the input in the search field -->
        <xf:action ev:event="xforms-ready">
            <xf:setfocus control="search-field"/>
        </xf:action>
        <xf:submission id="search" method="get" action="search.xq" replace="all"/>
    </xf:model>
    
let $content := 
<div class="content">    
    <body>
        <xf:input ref="q" id="search-field" incremental="true">
            <xf:label>Search:</xf:label>
            <!-- this makes the return perform a search -->
            <xf:action ev:event="DOMActivate">
                <xf:send submission="search"/>
            </xf:action>
        </xf:input>
        <xf:submit submission="search">
            <xf:label>Search</xf:label>
        </xf:submit>
    </body>
</div>

return style:assemble-page($title, $content)