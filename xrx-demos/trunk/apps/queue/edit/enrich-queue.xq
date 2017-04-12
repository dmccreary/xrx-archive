xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
(: Enrich Queue With Item Names :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $queue := collection($data-collection)/queue/id

return
<queue>{
   for $item in $queue
   return
   <item>
       <id>{$item/text()}</id>
       <name>{collection($data-collection)/item/name[../id=$item/text()]/text()}</name>
       <priority></priority>
   </item>
}</queue>
