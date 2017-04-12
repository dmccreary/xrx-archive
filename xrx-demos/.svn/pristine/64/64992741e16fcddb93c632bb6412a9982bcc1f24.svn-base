xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Metrics'

let $start-time := util:system-time()
let $count := count(collection($data-collection)//record)
let $end-time := util:system-time()
let $runtime := ($end-time - $start-time)
let $runtimems := ($runtime div xs:dayTimeDuration('PT1S'))  * 1000  

let $time-in-seconds := substring-before(substring-after(string($runtime), 'PT'), 'S')

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  
  Report generated in {$runtimems} milliseconds
  <table class="span-12">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td class="span-6">Number of Records: </td>
           <td class="span-6">{$count}</td>
        </tr>
    </tbody>
  </table>
  </div>

return style:assemble-page($title, $content)