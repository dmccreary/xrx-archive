xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace docbook2xhtml="http://exist-db.org/docbook2xhtml" at "../modules/docbook2xhtml.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";


let $id := request:get-parameter('id', '')

let $data-collection := $style:db-path-to-app-data
let $file-path := concat($data-collection, '/', $id)

let $doc := doc($file-path)

return docbook2xhtml:dispatch($doc)