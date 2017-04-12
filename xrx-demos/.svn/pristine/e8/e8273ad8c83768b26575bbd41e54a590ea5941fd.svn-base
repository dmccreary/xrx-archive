xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
(: update.xq :)
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Project Update Confirmation'
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := $item//id/text() 

let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)
let $doc := collection($data-collection)/GeneralProject[./id/text() = $id]
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()


let $content :=
<div class="content">
      <h4>Item {$id} has been updated.</h4>
  
   {style:edit-controls($id, 'evpx')}
      
</div>

return style:assemble-page($title, $content)