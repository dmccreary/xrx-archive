import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg = "http://www.w3.org/2000/svg";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";

let $title := 'Wrap all icons'
let $query := '04-wrap-all.xq'

let $number-accross := 8

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $svg-ids :=
   for $file-name in xmldb:get-child-resources($data-collection)
   order by $file-name
   return
      substring-before($file-name, '.svg')


return
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
version="1.1" id="Layer_1" x="0px" y="0px" width="900px" height="800px" viewBox="0 0 900 800" enable-background="new 0 0 900 800" xml:space="preserve">
    {style-svg:css-link()}
    {style-svg:drop-shadow()}
    {style-svg:gradient-fill()}
    {for $svg-id at $count in $svg-ids
       let $x := (($count - 1) mod $number-accross) * 110
       let $y := (($count - 1) idiv $number-accross) * 110
       return style-svg:icon-group(style-svg:svg-file($svg-id), $x, $y)
         }
</svg>