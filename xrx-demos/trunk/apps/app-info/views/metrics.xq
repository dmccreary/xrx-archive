xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Metrics'
let $categories := doc(concat($app-collection, '/code-tables/category-codes.xml'))/code-table

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
           <td class="span-6">Number of Items: </td>
           <td class="span-6">{count(collection($data-collection)/item)}</td>
        </tr>
    </tbody>
  </table>
  </div>

return style:assemble-page($title, $content)