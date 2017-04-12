xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $title := 'List Labs'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/labs')

let $content :=
<div class="content">
       <table class="span-24">
           <thead>
           <tr>
              <th class="span-1">ID</th>
              <th class="span-5">Name</th>
              <th class="span-10">Description</th>
              <th class="span-2">Status</th>
              <th class="span-5 last">Resources</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/lab
             let $id := $item/id/text()
             let $labs := train:count-labs-for-class($id)
             order by number($id)
          return
             <tr>
                 <td>{$id}</td>
                 <td><a href="view-lab.xq?id={$id}">{$item/name/text()}</a></td>
                 <td>{$item/description/text()}</td>
                 <td>{for $resource in $item//resources
                      return
                         <a>{$resource/name/text()}</a>
                  }</td>
                 <td>{$labs}</td>
                 <td>{$item/status/text()}</td>
                 <td>{$item/tag/text()}</td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)