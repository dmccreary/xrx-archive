xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Get Person Instance'

let $id := request:get-parameter('id', '')
(: check for required parameters :)
return
   if (not($id)) then <error><message>Error - missing required parameter: id</message></error> else

let $app-collection := $style:db-path-to-app

let $data-collection := concat($app-collection, '/data')

return collection($data-collection)//person[id/text() = $id][1]


