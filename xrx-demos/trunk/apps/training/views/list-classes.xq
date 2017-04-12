xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $title := 'List Classes'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/classes')

let $content :=
<div class="content">
       <table class="span-24">
           <thead>
           <tr>
              <th class="span-1">ID</th>
              <th class="span-3">Name</th>
              <th class="span-1">Level</th>
              <th class="span-1">Recomended Prerequsites</th>
              <th class="span-1"># Labs</th>
              <th class="span-1">Status</th>
              <th class="span-1 last">Tags</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/class
             let $id := $item/id/text()
             let $labs := train:count-labs-for-class($id)
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td><a href="view-class.xq?id={$id}">{$item/name/text()}</a></td>
                 <td>{train:level-label($item/category/text())}</td>
                 <td>{string-join($item/prerequsites/id/text(), ', ')}</td>
                 <td>{$labs}</td>
                 <td>{$item/status/text()}</td>
                 <td>{$item/tag/text()}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)