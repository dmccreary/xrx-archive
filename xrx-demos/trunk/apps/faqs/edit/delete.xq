xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $collection := '/db/dma/apps/faqs/data'
let $title :="Delete FAQ Confirmation"
(: this script takes the integer value of the id parameter passed via get :)
let $id := xs:integer(request:get-parameter('id', ''))

(: this logs you into the collection :)
let $login := xmldb:login($collection, 'admin', 'admin123')

(: this constructs the filename from the id :)
let $file := concat($id, '.xml')

(: this deletes the file :)
let $store := xmldb:remove($collection, $file)

let $content :=
<div class="content">
   <h4>FAQ id {$id} has been removed.</h4>
</div>

return style:assemble-page($title, $content)

