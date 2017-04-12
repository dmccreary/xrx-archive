xquery version "1.0";

(: Delete Item :)

import module namespace style = "http://style.exist-db.org/reference-manual" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', $id, '.xml')
 
(: this script takes the integer value of the id parameter passed via get :)
let $id := request:get-parameter('id', '')

(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', '')

(: this constructs the filename from the id :)
let $file := concat($id, '.xml')

(: this deletes the file :)
let $store := xmldb:remove($data-collection, $file)

let $content := <p>Security Role id="{$id}" has been removed.</p>

return 
    style:assemble-page($content)
