xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $id := request:get-parameter('id', '')



let $config :=
  <config>
   <view>view-class.xq?id=</view>
   <edit>../edit/edit-topic.xq?id=</edit>
   <delete>../edit/delete-confirm-topic.xq?id=</delete>
   <publish>../edit/publish-topic.xq?id=</publish>
   <xml>../edit/get-instance-topic.xq?id=</xml>
</config>

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/topics')
let $topic := collection($data-collection)//topic[./id/text() = $id]
let $name := $topic/name/text()
let $title := concat('View Topic: "', $name, '"' )

let $content :=
<div class="content">

 <table class="span-10">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$topic/id/text()}</td></tr>
     <tr><th class="field-label">Topic Name:</th><td>{$topic/name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$topic/description/text()}</td></tr>
     
     <tr><th class="field-label">Status:</th><td>{$topic/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$topic/tag/text()}</td></tr>
     </tbody>
  </table>
  
   {style:view-resources($topic/resources)}
  
   {style:edit-controls($id, 'edx', $config)}
</div>

return style:assemble-page($title, $content)