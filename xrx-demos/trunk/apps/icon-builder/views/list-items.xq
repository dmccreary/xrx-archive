xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace style-svg = "http://danmccreary.com/style-svg" at "../modules/icon-builder.xqm";
declare namespace svg = "http://www.w3.org/2000/svg";

let $title := 'List SVG Icons'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table class="datatable span-10">
           <thead>
           <tr>
              <th class="span-3">ID</th>
              <th class="span-6">Description</th>
              <th class="span-2">Icon</th>
              <th class="span-1">View</th>
           </tr>
        </thead>
        <tbody>{
          for $item at $count in collection($data-collection)/svg:svg
             let $id := substring-before(util:document-name($item), '.svg')
             let $svg-doc := style-svg:svg-file($id)
             order by $id
          return
             <tr>
                 {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
                 }
                 <td>{$id}</td>
                 <td>{$item/svg:desc/text()}</td>
                 <td>{style-svg:mini-icon-wrap(style-svg:svg-file($id))}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

(: TODO - fix me so that HTML and SVG render in the same page 
style-svg:assemble-page($title, $content)
:)
return style:assemble-page($title, $content)