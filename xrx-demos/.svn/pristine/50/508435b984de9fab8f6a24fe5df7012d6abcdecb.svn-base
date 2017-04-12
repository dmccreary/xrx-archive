import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://www.danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg   = "http://www.w3.org/2000/svg";

let $id := request:get-parameter('id', 'alarm-clock-np291')

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $file-path := concat($data-collection, '/', $id, '.svg')
let $input := doc($file-path)/svg:svg
let $output := style-svg:add-css-link($input)

return
<test>
   <id>{$id}</id>
   <input>{$input}</input>
   <output>{$output}</output>
</test>