xquery version "1.0";

(: Update Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($item//id/text())
let $title := concat('Update Confirmation for item ', $id)
let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)

(: this updates the last modified by, date and time of the record just saved :)
let $doc := collection($data-collection)/user[./id/text() = $id]
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()

let $content := 
    <div>
        <p>Item {$id} has been updated.</p>
        
        <div class="edit-controls">
            <a href="../views/view-item.xq?id={$id}" title="View {$id}">View User</a>
            <a href="../views/list-items.xq" title="List items">List all users</a>
                      
        </div>
    </div>
    
return style:assemble-page($title, $content)