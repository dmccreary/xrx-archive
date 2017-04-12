xquery version "1.0";

(: Update Security Role :)

import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
let $title := 'Update Security Role'
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($item//id/text())
let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)
let $doc := collection($data-collection)/security-role[./id/text() = $id]
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()


let $content := 
    <div>
        <p>Security Role {$id} has been updated.</p>
        <div class="edit-controls">
            <a href="../edit/edit.xq?id={$id}" title="Edit {$id}">Edit</a>
            <a href="../views/view-item.xq?id={$id}" title="View {$id}">View</a>
            <a href="../edit/delete-confirm.xq?id={$id}" title="Delete {$id}">Delete</a>
            <a href="../data/{$id}.xml" title="Delete {$id}">View XML</a>
        </div>
    </div>
    
return style:assemble-page($title, $content)
