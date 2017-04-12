xquery version "1.0";

(: Delete Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")
let $title :='Delete Book'
let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', 'books-sample', '.xml')

(: this script takes the integer value of the id parameter passed via get :)
let $id := request:get-parameter('id', '')

(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: this deletes the file :)
let $store := update delete doc($doc)/books/book[$id = id]

let $content := <p>Book id="{$id}" has been removed.</p>

return 
    style:assemble-page($title, $content)