xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th class="span-10">Event Location</th>
              <th>Latitude</th>
              <th>Longitude</th>
              <th>Event Date</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)//event
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/event-location/text()}</td>                
                 <td>{$item/lat/text()}</td>
                 <td>{$item/long/text()}</td>
                 <td>{$item/event-date/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)