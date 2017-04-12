xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/ns/style/1.0" at "../../../modules/style.xqm";

declare function local:max-length($string-seq as xs:string*) as xs:string* {
  let $max := max (for $s in  $string-seq  return string-length($s))
  return $string-seq[string-length(.) = $max]
};
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-file := concat($app-collection, '/code-tables/item-category-codes.xml')


let $content :=
<div class="content">
       <h1>Item Metrics</h1>
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
               <td>{count(collection($data-collection)/item)}</td>
            </tr>
             <tr>
               <td  align="right">Count of FAQ Categories:</td>
               <td>{count( doc($code-table-file)/code-table/items/item )}</td>
            </tr>
             <tr>
               <td  align="right">Longest name:</td>
               <td>{local:max-length(collection($data-collection)/item/name/text())}</td>
            </tr>
             <tr>
               <td  align="right">Longest description:</td>
               <td>{local:max-length(collection($data-collection)/item/description/text())}</td>
            </tr>
          </tbody>
       </table>
</div>

return style:assemble-page($content)