xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')

return
collection ($data-collection)/sch:schema[sch:filename/string() = $id]