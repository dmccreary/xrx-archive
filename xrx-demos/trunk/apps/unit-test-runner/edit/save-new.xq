xquery version "1.0";

(: Save New Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace kert = "http://kuberam.ro/ns/kert";

let $app-collection := $style:db-path-to-app
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()

(: get the next ID from the POST :)

(: get the next ID from the next-id.xml file :)
let $next-id-file-path := concat($app-collection, '/edit/next-id.xml')
let $id := doc($next-id-file-path)/data/next-id/text() 
let $title := concat('Save Item ', $id)
let $file := concat($id, '.xml')

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

let $doc-path := concat($data-collection, '/crypto-tests.xml')

(: this appends a new node to the end of the file :)
let $insert-at-end := update insert $item into doc($doc-path)/kert:test-plan

(: this adds the correct ID to the new document we just saved :)
let $update-id := update value collection($data-collection)//kert:test[last()]/@id with $id

let $doc := collection($data-collection)//kert:test[@id = $id]
let $update := update value $doc/kert:created-by with xmldb:get-current-user()
let $update := update value $doc/kert:created-datetime with current-dateTime()

(: this updates the next-id.xml file :)
let $new-next-id := update replace doc($next-id-file-path)/data/next-id/text() with ($id + 1)

(: we need to return the original ID number in our results, but $id has already been increased by 1 :)
let $original-id := string($id - 1)

let $content := 
    <div>
        <p>Test {$original-id} has been saved.</p>
        {style:edit-controls($original-id, 'evpx')}
    </div>

return style:assemble-page($title, $content)