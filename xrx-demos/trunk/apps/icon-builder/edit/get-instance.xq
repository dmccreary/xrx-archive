xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace style-svg = "http://www.danmccreary.com/style-svg" at "../modules/icon-builder.xqm";

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else style-svg:svg-file($id)