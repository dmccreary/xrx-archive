xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $events := collection($data-collection)//event

return
<results>{
for $event at $count in $events[not(id)]
    let $update := update insert <id>{$count}</id> preceding $event/creator_student
    return
      <updating> {$count}</updating> 

}</results>