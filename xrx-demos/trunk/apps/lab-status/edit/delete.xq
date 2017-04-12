xquery version "1.0";

(: Delete Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, $id, '.xml')
let $title :='Student delete confirmation'
(: this script takes the integer value of the id parameter passed via get :)
let $id := request:get-parameter('id', '')

(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: this constructs the filename from the id :)
let $file := concat($id, '.xml')

(: this deletes the file :)
let $store := xmldb:remove($data-collection, $file)

let $content := <p>Student Record id="{$id}" has been removed.</p>

return 
    style:assemble-page($title, $content)