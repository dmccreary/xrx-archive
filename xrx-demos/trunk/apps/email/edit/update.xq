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
let $title := concat('Update Message Confirmation ', $id)
let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)

let $content := 
    <div>
        <p>Message {$id} has been updated.</p>
        
        <a href="../views/view-item.xq?id={$id}" title="View {$id}">View Message {$id}</a>
        <br/><br/>
        {style:edit-controls($id, 'evpx')}
    </div>
    
return style:assemble-page($title, $content)