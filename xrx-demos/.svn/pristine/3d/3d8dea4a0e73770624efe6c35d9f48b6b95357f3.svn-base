import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg = "http://www.w3.org/2000/svg";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";

let $title := 'Wrap all icons'
let $query := '04-wrap-all.xq'


let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $svg-ids :=
   for $file-name in xmldb:get-child-resources($data-collection)
   order by $file-name
   return
      substring-before($file-name, '.svg')


let $content := 
    <div class="content">
        <xhtml:style>a {{text-decoration:none;}}</xhtml:style>
        {style-svg:drop-shadow()}
        {style-svg:gradient-fill()}
        {for $svg-id in $svg-ids
         return

             <xhtml:a href="../views/view-item.xq?id={$svg-id}" title="{$svg-id}">
             
             {style-svg:mini-icon-wrap(style-svg:svg-file($svg-id))}
             </xhtml:a>

         }
       
    </div>                                           

return $content