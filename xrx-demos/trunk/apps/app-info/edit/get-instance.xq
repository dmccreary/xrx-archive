xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace app-info = "http://www.danmccreary.com/app-info" at "../modules/app-info-module.xqm";
declare namespace xrx="http://code.google.com/p/xrx";

(: Get Instance - returns the XML item for a given ID :)

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return

if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else

let $site-root-collection := $style:db-path-to-site

let $site-root-collection := $style:db-path-to-site
let $file := concat($site-root-collection, '/apps/', $id, '/app-info.xml')
let $item := doc($file)/xrx:app-info[xrx:app-id/text() = $id]
return $item

