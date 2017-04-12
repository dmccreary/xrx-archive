xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
(: update.xq :)

let $title := 'Term Update Confirmation'
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
 
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := $item//id/text() 

let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := update replace collection($data-collection)//term[id = $id] with $item
let $doc := collection($data-collection)/terms[./id/text() = $id]
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()



let $content :=
<div class="content">
    <p>Term {$id} has been updated.</p>
    {style:edit-controls($id, 'evpx')}
</div>

return style:assemble-page($title, $content)