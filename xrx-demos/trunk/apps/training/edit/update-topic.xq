xquery version "1.0";

(: Update Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()
let $description := normalize-space($item/description/text())
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($item//id/text())
let $title := concat('Update Confirmation for topic ', $id)
let $file := concat($id, '.xml')

let $config :=
  <config>
   <view>../views/view-topic.xq?id=</view>
   <edit>../edit/edit-topic.xq?id=</edit>
   <delete>../edit/delete-confirm-topic.xq?id=</delete>
   <publish>../edit/publish-topic.xq?id=</publish>
   <xml>../edit/get-instance-topic.xq?id=</xml>
</config>
 
(: this updates the new record with the old one :)
let $update := update replace collection($data-collection)//topic[./id/text() = $id] with $item
let $update := update value collection($data-collection)//topic[./id/text() = $id]/description with $description

let $content := 
    <div>
        <p>Topic {$id} has been updated.</p>
        
        <br/>
        {style:edit-controls($id, 'vex', $config)}
    </div>
    
return style:assemble-page($title, $content)