xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";



let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Lab Status Metrics'

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  
  <table border="1">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td align="right">Number of Students: </td>
           <td>{count(collection($data-collection)/student)}</td>
        </tr>
     </tbody>
   </table>
   
    
</div>

return style:assemble-page($title, $content)