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
let $title := concat('Update Confirmation for Event ID # ', $id)
 
(: this saves the new file and overwrites the old one :)
let $doc := collection($data-collection)//event[id/text() = $id]
let $update := update replace collection($data-collection)//event[id/text() = $id] with $item 
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()

let $content := 
    <div>
        <p>Event {$id} has been updated.</p>       
        <br/>
        {style:edit-controls($id, 'evpx')}
    </div>
    
return style:assemble-page($title, $content)