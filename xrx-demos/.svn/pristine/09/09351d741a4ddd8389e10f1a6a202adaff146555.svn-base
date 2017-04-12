xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'XML Schema Details Report'

let $file := request:get-parameter('file', '')

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema
let $transaction-types := $schema//xs:complexType[@name='BodyType']/xs:choice/xs:element/string(@ref)

let $content :=
<div class="content">
<p>XML Transasctions for: <b>{$file}</b></p>

<p>Transaction Count = {count($transaction-types)}</p>
<table class="span-14 last">
   <thead>
      <tr>
         <th class="span-8">Element</th>
         <th class="span-3">View Complex Type</th>
      </tr>
   </thead>
   <tbody>
       {for $transaction in $transaction-types
       return
       
           <tr>
              <td>{$transaction}</td>
              <td><a href="view-complex-type.xq?file={$file}&amp;complex-type={$transaction}">View Type</a></td>
           </tr>
       }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)