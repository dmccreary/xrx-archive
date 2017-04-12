xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := $style:db-path-to-app-data
let $title :='Event Metrics'

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  <table class="span-12">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td class="span-6">Number of Events: </td>
           <td class="span-6">{count(collection($data-collection)//event)}</td>
        </tr>
    </tbody>
  </table>
  </div>

return style:assemble-page($title, $content)