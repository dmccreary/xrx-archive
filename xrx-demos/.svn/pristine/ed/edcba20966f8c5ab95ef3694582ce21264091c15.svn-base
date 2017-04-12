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
let $title := concat('Update Confirmation for class ', $id)
let $file := concat($id, '.xml')

let $config :=
  <config>
   <view>../views/view-class.xq?id=</view>
   <edit>edit-class.xq?id=</edit>
   <delete>delete-confirm-class.xq?id=</delete>
   <publish>../edit/publish-class.xq?id=</publish>
   <xml>get-instance-class.xq?id=</xml>
</config>
 
(: this updates the new record with the old one :)
let $update := update replace collection($data-collection)//topic[./id/text() = $id] with $item
let $update := update value collection($data-collection)//topic[./id/text() = $id]/description with $description

let $content := 
    <div>
        <p>Class {$id} has been updated.</p>
        
        <a href="../views/view-class.xq?id={$id}" title="View {$id}">View Item {$id}</a>
        <br/>
        <br/>
        {style:edit-controls($id, 'vex', $config)}
    </div>
    
return style:assemble-page($title, $content)