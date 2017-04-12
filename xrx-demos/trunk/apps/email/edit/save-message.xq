xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $title := 'Save an E-mail Message with Classifiers Updated'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection , '/data')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()

(: get the message ID out of the incomming POSTed file :)
let $id := $item/id/text()
let $file-name := concat($id, '.xml')
let $full-path := concat($data-collection, '/', $file-name)

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file-name, $item)

let $content :=
<div class="content">
      <p>Message {$id} has been saved to {$full-path}</p>
      
      {style:edit-controls($id, 'evpx')}
      

      
</div>

return style:assemble-page($title, $content)
