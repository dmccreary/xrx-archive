xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
(: save-new.xq :)

let $title := 'Save New Requirement'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection , '/data')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: get the next ID from the next-id.xml file :)
let $next-id-file-path := concat($app-collection,'/edit/next-id.xml')
let $id := doc($next-id-file-path)/data/next-id/text() 
let $file := concat($id, '.xml')

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file, $item)
let $file-path := concat($data-collection, '/', $file)

(: this adds the correct ID to the new document we just saved :)
let $update-id :=  update replace doc($file-path)/Requirement/id with <id>{$id}</id>

(: this updates the next-id.xml file :)
let $new-next-id := update replace doc($next-id-file-path)/data/next-id/text() with ($id + 1)

let $update-create-datetime := update value doc($file-path)/Requirement/created-datetime with current-dateTime()

(: we need to return the original ID number in our results, but $id has already been increased by 1 :)
let $original-id := ($id - 1)

let $content :=
<div class="content">
      <p>Requirement {$original-id} has been saved.</p>
      
      <a class="button-control" href="../views/view-item.xq?id={$original-id}">View Item</a>
      
      <a class="button-control" href="../views/list-items.xq">List all Requirements</a>
      
      <a class="button-control" href="../views/hierarchy.xq">View Requirement Hierarchy</a>
      
      <a class="button-control" href="edit.xq?new=true">Create New Requirement</a>
      
</div>

return style:assemble-page($title, $content)
