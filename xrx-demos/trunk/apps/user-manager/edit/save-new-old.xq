xquery version "1.0";

(: Save New Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()


(: get the next ID from the POST :)

(: get the next ID from the next-id.xml file :)
let $next-id-file-path := concat($app-collection,'/edit/next-id.xml')
let $id := doc($next-id-file-path)/data/next-id/text() 
let $title := concat('Save Item ', $id)
let $file := concat($id, '.xml')

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file, $item)

(: this adds the correct ID to the new document we just saved :)
let $update-id := update replace doc(concat($data-collection, '/', $file))/user/id with <id>{$id}</id>

(: this updates the next-id.xml file :)
let $new-next-id := update replace doc($next-id-file-path)/data/next-id/text() with ($id + 1)

(: we need to return the original ID number in our results, but $id has already been increased by 1 :)
let $original-id := ($id - 1)

let $content := 
    <div>
        <p>Item {$original-id} has been saved.</p>
        <div class="edit-controls">
            <a href="../edit/edit.xq?id={$original-id}" title="Edit {$original-id}">Edit</a>
            <a href="../edit/delete-confirm.xq?id={$original-id}" title="Delete {$original-id}">Delete</a>
            <a href="../data/{$original-id}.xml" title="Delete {$original-id}">View XML</a>
        </div>
    </div>

return style:assemble-page($title, $content)