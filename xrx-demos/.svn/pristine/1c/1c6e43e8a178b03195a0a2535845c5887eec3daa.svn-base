xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
(: update.xq :)

let $title := 'Update Requirement'
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := $item//id/text()
return
   if (string-length($id) lt 1)
   then
    <error>
       <message>Invalid ID.  The incomming HTTP post does not have a valid id element</message>
       <data>{$item}</data>
    </error>
   else

let $file := concat($id, '.xml') 
let $file-path := concat($data-collection, '/', $file)
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($data-collection, $file, $item)
let $doc := collection($data-collection)/Requirement[./id/text() = $id]
let $update := update value $doc/last-modified-by with xmldb:get-current-user()
let $update := update value $doc/last-modified-datetime with current-dateTime()



let $content :=
<div class="content">
       <p>Requirement {$id} has been updated. by {xmldb:get-current-user()} on {current-dateTime()}</p>
       
    
     {style:edit-controls($id, "edpx")}
</div>

return style:assemble-page($title, $content)