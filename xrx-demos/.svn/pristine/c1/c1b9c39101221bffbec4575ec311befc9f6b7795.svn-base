xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := '/db/dma/apps/faqs'
let $data-collection := concat($app-collection, '/data')
let $code-table-file := concat($app-collection, '/code-tables/faq-category-codes.xml')
let $title :='FAQ Metrics'

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  <b>Code Table: </b>{$code-table-file}
  <table border="1">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td align="right">Count of FAQs: </td>
           <td>{count(collection($data-collection)/faq)}</td>
        </tr>
         <tr>
           <td  align="right">Count of FAQ Categories:</td>
           <td>{count( doc($code-table-file)/code-table/items/item )}</td>
        </tr>
         <tr>
           <td  align="right">Longest Question:</td>
           <td>{style:max-length(collection($data-collection)/faq/question)}</td>
        </tr>
         <tr>
           <td  align="right">Longest Answer:</td>
           <td>{style:max-length(collection($data-collection)/faq/answer)}</td>
        </tr>
      </tbody>
   </table>
</div>

return style:assemble-page($title, $content)