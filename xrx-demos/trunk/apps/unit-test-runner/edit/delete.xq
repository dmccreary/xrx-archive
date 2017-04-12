xquery version "1.0";

(: Delete Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace kert = "http://kuberam.ro/ns/kert";
declare default element namespace "http://kuberam.ro/ns/kert";


let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data

(: this script takes the integer value of the id parameter passed via get :)
let $id := request:get-parameter('id', '')

let $title := concat('Delete Unit Test ', $id)

let $item := collection($data-collection)//kert:test[@id = $id]

(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: this deletes the item :)
let $update := update delete $item

let $content := <div class="content">Unit Test id="{$id}" has been removed.</div>

return 
    style:assemble-page($title, $content)