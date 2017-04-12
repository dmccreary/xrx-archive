import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg   = "http://www.w3.org/2000/svg";

let $id := request:get-parameter('id', 'alarm-clock-np291')
let $title := 'Icon Wrap Test'

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

let $content :=
<div class="content">

   {style-svg:drop-shadow()}
    {$id}
    Input with CSS {$input}<br/>
    With icon wrap: {$output}<br/>

</div>

return style-svg:assemble-page($title, $content)