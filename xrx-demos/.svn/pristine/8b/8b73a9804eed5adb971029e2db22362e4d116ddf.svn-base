xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $title := 'Save Code Table'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection , '/code-tables')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
let $code-table-name := $item/code-table-name/text()
let $file-name := concat($code-table-name, '.xml')
let $full-path := concat($data-collection, '/', $file-name)

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file-name, $item)

let $content :=
<div class="content">
      <p>Code Table {$code-table-name} has been saved to {$full-path}</p>
      
      <a href="../views/view-code-table.xq?id={$code-table-name}">View  </a>
      
      <a href="../edit/edit-code-table.xq?id={$code-table-name}">Edit  </a>
         
     <a href="../code-tables/{$file-name}">XML</a>  
</div>

return style:assemble-page($title, $content)
