xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";

declare namespace svg = "http://www.w3.org/2000/svg";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";

let $id := request:get-parameter('id', '')
let $title := concat('View item ', $id)

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
let $item := doc($file-path)/svg:svg

let $content :=
<div class="content">
  {$item}
  {style-svg:icon-wrap(style-svg:svg-file($id))}

</div>

return style-svg:assemble-page($title, $content)