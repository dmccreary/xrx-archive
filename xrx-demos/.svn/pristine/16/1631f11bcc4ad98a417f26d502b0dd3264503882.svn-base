xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title :='Term Metrics'
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $dashboard-document := concat($app-collection, '/data/dashboard-terms.xml')
let $credit-document := concat($app-collection, '/data/credit-analysis-terms.xml')
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
               <td align="right">Count of Company Terms: </td>
               <td>{count(collection($data-collection)/term)}</td>
            </tr>
             <tr>
               <td  align="right">Count of Reference Terms - Dashboard:</td>
               <td>{count(doc($dashboard-document)//term)}</td>
            </tr>
             <tr>
               <td  align="right">Count of Referece Terms - Credit Analysis:</td>
               <td>{count(doc($credit-document)//term)}</td>
            </tr>
         </tbody>
       </table>
</div>

return style:assemble-page($title, $content)