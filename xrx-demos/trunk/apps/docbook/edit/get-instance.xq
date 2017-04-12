xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=application/xml omit-xml-declaration=yes indent=yes";

(: Get Instance - returns the XML item for a given ID :)

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else

(: todo - put in enrich library here :)

let $data-collection := $style:db-path-to-app-data
let $file-path := concat($data-collection, '/', $id)
let $item := doc($file-path)/*
return <book><bookinfo>{$item/bookinfo/*}</bookinfo></book>

