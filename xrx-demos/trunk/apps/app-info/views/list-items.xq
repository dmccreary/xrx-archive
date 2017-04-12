xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace xrx="http://code.google.com/p/xrx";

let $title := 'List XRX App Info files'

let $site-root-collection := $style:db-path-to-site
let $app-info-files := collection($site-root-collection)/xrx:app-info

let $sorted-app-info-files :=
   for $app in $app-info-files
   order by $app/xrx:app-id
   return $app

let $content :=
<div class="content">
Root Collection := {substring-after($site-root-collection, 'xmldb:exist://')} Count = {count($app-info-files)}
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Description</th>
              <th>Classifiers</th>
              <th>Status</th>
              <th>Tag</th>
           </tr>
        </thead>
        <tbody>{
          for $item at $count in $sorted-app-info-files
             let $id := $item/xrx:app-id/text()
             order by $id
          return
             <tr>
                 {if ($count mod 2)
                     then attribute class {'odd'}
                     else attribute class {'even'}
                 }
                 <td><a href="view-item.xq?id={$id}">{$id}</a></td>
                 <td>{$item/xrx:app-name/text()}</td>
                 <td>{$item/xrx:app-description-text/text()}</td>
                 <td>{string-join($item//xrx:classifier/text(), ', ' )}</td>
                 <td>{util:collection-name($item)}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)