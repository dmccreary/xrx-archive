xquery version "1.0";

(: Update Unit Test from Form :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace kert = "http://kuberam.ro/ns/kert";

let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($item//@id)
let $title := concat('Update Confirmation for item ', $id)

let $test-on-disk := collection($data-collection)//kert:test[@id = $id]
 
(: this puts the revised test over the old one :)
let $replace := update replace $test-on-disk with $item
let $update := update value $test-on-disk/kert:last-modified-by with xmldb:get-current-user()
let $update := update value $test-on-disk/kert:last-modified-datetime with current-dateTime()
let $content := 
    <div>
        <p>Test {$id} has been updated.</p>
        
        <br/>
        {style:edit-controls($id, 'evpx')}
    </div>
    
return style:assemble-page($title, $content)