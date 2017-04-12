xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

let $file := request:get-parameter('file', '')

let $file-path := concat($style:db-path-to-app, '/unit-tests/', $file)
return doc($file-path)
