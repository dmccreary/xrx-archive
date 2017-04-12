import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg   = "http://www.w3.org/2000/svg";

let $id := request:get-parameter('id', 'alarm-clock-np291')
let $title := 'Gradient Fill Test 2'

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
let $output := style-svg:icon-wrap($input)

return
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" width="100px" height="100px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve">
    <desc>Alarm Clock</desc>
    {style-svg:drop-shadow()}
    {style-svg:gradient-fill()}
    {style-svg:border()}
    <g fill="url(#upper-left-light-source)" transform="scale(.85, .83) translate(5,5)" style="filter:url(#dropshadow)">
       <circle cx="50" cy="50" r="40"/>
    </g>
    
</svg>