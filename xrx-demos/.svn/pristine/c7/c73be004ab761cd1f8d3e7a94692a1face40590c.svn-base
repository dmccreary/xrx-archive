xquery version "1.0";
declare namespace xrx="http://code.google.com/p/xrx";
(: Save New Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()

(: get the next ID from the POST :)

(: get the next ID from the next-id.xml file 
let $next-id-file-path := concat($app-collection,'/edit/next-id.xml')
let $id := doc($next-id-file-path)/data/next-id/text() 
let $title := concat('Save AppInfo ', $id)
let $file := concat($id, '.xml')
:)
(: this logs you into the collection 
let $login := xmldb:login($app-collection, 'admin', 'admin123')
:)

(: this creates the new file with a still-empty id element
let $store := xmldb:store($data-collection, $file, $item)
:)

(: this adds the correct ID to the new document we just saved 
let $update-id := update replace doc(concat($data-collection, '/', $file))/item/id with <id>{$id}</id>

let $doc := collection($data-collection)/item[./id/text() = $id]
let $update := update value $doc/created-by with xmldb:get-current-user()
let $update := update value $doc/created-datetime with current-dateTime()
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()
:)


let $content := 
    <div>
        <p>AppInfo Editor Sorry, the save new function (Create Application) has been disabled in this demo.</p>
       {(: style:edit-controls($original-id, 'evpx') :)}
    </div>

return style:assemble-page($title, $content)