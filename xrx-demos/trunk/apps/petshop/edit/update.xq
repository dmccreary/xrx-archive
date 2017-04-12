xquery version "1.0";

(: Update Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($item/id/text())
let $title := concat('Update Confirmation for item ', $id)
let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)

let $content := 
    <div>
        <p>Item {$id} has been updated.</p>
        
        <a href="../views/view-animal.xq?id={$id}" title="View {$id}">View Animal {$id}</a><br/>br/>
        
        <div class="edit-controls">
            <a href="../edit/edit.xq?id={$id}" title="Edit {$id}">Edit</a>
            <a href="../edit/delete-confirm.xq?id={$id}" title="Delete {$id}">Delete</a>
            
            <a href="../edit/get-instance.xq?id={$id}" title="View XML {$id}">View XML</a>
        </div>
    </div>
    
return style:assemble-page($title, $content)