xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-file := concat($app-collection, '/code-tables/message-classification-codes.xml')
let $title :='Message Metrics'

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  <b>Code Table: </b>{$code-table-file}
  <table border="1">
  <thead>
       <tr>
     
          <th class="span-5"> Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td align="right">Count of Messages: </td>
           <td>{count(collection($data-collection)/message)}</td>
        </tr>
         <tr>
           <td  align="right">Count of Message Categories:</td>
           <td>{count( doc($code-table-file)/code-table/items/item )}</td>
        </tr>
         <tr>
           <td  align="right">Longest Message:</td>
           <td>{style:max-length(collection($data-collection)/message/body)}</td>
        </tr>
     </tbody>
   </table>
</div>

return style:assemble-page($title, $content)