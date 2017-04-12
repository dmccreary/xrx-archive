xquery version "1.0";

import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

let $title := 'View Unit Test Data'

let $id := request:get-parameter('id', '')
(: check for required parameters :)
return
   if (not($id)) then <error><message>Error - missing required parameter: id</message></error> else

let $app-collection := $style:db-path-to-app

let $data-collection := concat($app-collection, '/data')

let $unit-test := collection($data-collection)//unit-test[id/text() = $id]


return $unit-test
