xquery version "1.0";

(: Save New Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Save Term Confirmation'

let $app-collection := $style:db-path-to-app
let $data-collection := $style:db-path-to-app-data
let $incomming-data := request:get-data()

let $next-id-file-path := concat($app-collection,'/edit/next-id.xml')
let $id := doc($next-id-file-path)/data/next-id/text() 

let $file := concat($id, '.xml')

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file, $incomming-data)

(: this adds the correct ID to the new document we just saved :)
let $update-id := update replace doc(concat($data-collection, '/', $file))/term/id with <id>{$id}</id>

let $doc := collection($data-collection)/term[./id/text() = $id]
let $update := update value $doc/created-by with xmldb:get-current-user()
let $update := update value $doc/created-datetime with current-dateTime()

(: this updates the next-id.xml file :)
let $increment-update := update replace doc($next-id-file-path)/data/next-id/text() with ($id + 1)

(: we need to return the original ID number in our results, but $id has already been increased by 1 :)
let $original-id := string($id - 1)

let $content := 
    <div>
        <p>New term {$original-id} has been saved into file {$file}.</p>       
        {style:edit-controls($original-id, 'evpx')}
    </div>

return style:assemble-page($title, $content)