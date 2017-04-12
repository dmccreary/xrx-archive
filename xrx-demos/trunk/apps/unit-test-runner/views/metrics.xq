xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace kert = "http://kuberam.ro/ns/kert";
declare default element namespace "http://kuberam.ro/ns/kert";
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Metrics'
let $categories := doc(concat($app-collection, '/code-tables/development-status-codes.xml'))/code-table

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
           <td class="span-6">Number of Unit Tests: </td>
           <td class="span-6">{count(collection($data-collection)//kert:test)}</td>
        </tr>
    </tbody>
  </table>
  </div>

return style:assemble-page($title, $content)