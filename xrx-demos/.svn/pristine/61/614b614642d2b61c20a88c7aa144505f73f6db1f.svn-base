xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace util2 = "http://surescripts.com/util2" at "../../../modules/util2.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'View Transaction Types'

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $all-schemas := xmldb:get-child-resources($input-data-collection)

let $schemas :=
   for $schema in $all-schemas
   return
      if (starts-with(lower-case($schema), 's'))
         then $schema
         else ()

let $content :=
<div class="content">
<p>The following is a list of XML Schemas (that start with the letter 's') used to validate messages.</p>
<table class="span-23 last">
   <thead>
      <tr>
         <th class="span-6">File Name</th>
         <th class="span-1">Count</th>
         <th class="span-1">XSD</th>
         <th class="span-1">Browse</th>
         <th class="span-13 last">Transaction Types (BodyType/choice elements)</th>
      </tr>
   </thead>
   <tbody>
    {
    for $schema in $schemas
       let $file-path := concat($input-data-collection, '/', $schema)
       let $schema-doc := doc($file-path)/xs:schema
    let $transaction-types :=
       $schema-doc//xs:complexType[@name='BodyType']/xs:choice/xs:element/string(@ref)

    
    order by $schema
    return
       <tr>
          <td>{$schema}</td>
          <td>{count($transaction-types)}</td>
          <td><a href="../data/{$schema}">XSD</a></td>
          
          <td><a href="schema-transactions.xq?file={$schema}">Browse Transactions</a></td>
          <td>{for $transaction in $transaction-types
               return
                 <a href="view-complex-type.xq?complex-type={$transaction}">{$transaction}</a>}
          </td>
       </tr>
       
    }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)