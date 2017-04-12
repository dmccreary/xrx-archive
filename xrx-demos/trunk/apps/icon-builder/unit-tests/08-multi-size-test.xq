import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg   = "http://www.w3.org/2000/svg";
declare default element namespace "http://www.w3.org/1999/xhtml";

let $id := request:get-parameter('id', 'alarm-clock-np291')
let $title := 'Multi-size Wrap Test'

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

let $content :=
<div class="content">

16  = {style-svg:icon-wrap($input, 16)}<br/>
24  = {style-svg:icon-wrap($input, 24)}<br/>
32  = {style-svg:icon-wrap($input, 32)}<br/>
50  = {style-svg:icon-wrap($input, 50)}<br/>
100 = {style-svg:icon-wrap($input, 100)}<br/>
200 = {style-svg:icon-wrap($input, 200)}<br/>

</div>

return style-svg:assemble-page($title, $content)
