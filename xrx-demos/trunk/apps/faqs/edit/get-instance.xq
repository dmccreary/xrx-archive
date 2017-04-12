xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

return
collection ($data-collection)/faq[./id/text() = $id]