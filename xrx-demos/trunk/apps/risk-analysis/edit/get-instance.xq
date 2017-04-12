xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
(: Get Instance - returns the XML item for a given ID :)

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else
    let $data-collection := $style:db-path-to-app-data
    let $item := collection($data-collection)/*[./id/text() = $id]
    return $item

