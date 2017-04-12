xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'DocBook Files'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $documents := collection($data-collection)/book

let $content :=
<div class="content">
Count = {count($documents)}
       <table class="span-23 last">
           <thead>
           <tr>
              <th class="span-5">Title</th>
              <th class="span-1">Length</th>
              <th class="span-1">Status</th>
              <th class="span-1">Priority</th>
              <th class="span-2">Assigned To</th>
              <th class="span-3 last">Tags</th>
           </tr>
        </thead>
        <tbody>{
          for $item in $documents
             let $title := $item/bookinfo/title/text()
             let $id := util:document-name($item)
             order by $title
          return
             <tr>
                 <td><a href="docbook2xhtml.xq?id={$id}">{$title}</a></td>
                 <td>{xmldb:size($data-collection, $id)}</td>
                 <td>{if ($item/status/text()) then $item/status/text() else 'db4'}</td>
                 <td>{if ($item/prioity/text()) then $item/prioity/text() else 'medium'}</td>
                 <td>{if ($item/assigned-to/text()) then $item/assigned-to/text() else 'unassigned'}</td>
                 <td>{$item/tag/text()}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)