xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util = "http://code.google.com/p/xrx/schema-util" at "../modules/schema-utils.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'XML Schema Metrics'

let $file := request:get-parameter('file', '')

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema

let $names := for $name in $schema//@name
    return string($name)

let $distinct-names := distinct-values($names)

(: sort and remove lowercase types :)
let $sorted-names :=
   for $name in $distinct-names
   let $first-letter := substring($name, 1, 1)
   let $first-letter-caps := upper-case($first-letter)
   order by $name 
   return
      if ( compare($first-letter, $first-letter-caps) )
         then ()
         else $name
         
let $remove-types :=
   for $name in $sorted-names
   return
      if ( matches($name, 'Type$') )
         then ()
         else $name
         
let $content :=
<div class="content">
<p>Distinct XML Schema Names Report for : <b>{$file}</b></p>

Total Number of Named Types = {count($distinct-names)}<br/>

<table class="span-20 last">
   <thead>
      <tr>
         <th class="span-6">Name</th>
         <th class="span-2">Count</th>
         <th class="span-12">Types</th>
      </tr>
   </thead>
   <tbody>
       {for $name in $remove-types
        return
        <tr>
           <td>{string($name)}</td>
           
           <td>{sch-util:count-named-items($schema, $name)} </td>
           <td>{sch-util:types-for-name($schema, $name)}</td>
        </tr>
       }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)