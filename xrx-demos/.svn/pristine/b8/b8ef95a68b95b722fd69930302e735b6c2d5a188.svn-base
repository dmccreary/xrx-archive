xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util = "http://code.google.com/p/xrx/schema-util" at "../../schemas/modules/schema-utils.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace tei="http://www.tei-c.org/ns/1.0";



let $file := request:get-parameter('file', 'teilite.xsd')

let $title := concat('XML Schema Metrics for ', $file)

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

let $app-collection := $style:db-path-to-app

let $input-data-collection := concat($app-collection, '/tei-lite')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema

(: what we want is all elements that have a @name attribute, but lest us first get the names :)
let $names := for $name in $schema//@name
    return $name/string()

let $distinct-names := distinct-values($names)

(: sort and remove lowercase types :)
let $sorted-filtered-names :=
   for $name in $distinct-names
   order by $name 
   return
      if ( contains($name, 'model') or contains($name, 'att') or contains($name, 'macro') or 
      ($name = 'TEI') or ($name = 'body'))
         then ()
         else $name
         
let $remove-types :=
   for $name in $sorted-filtered-names
   return
      if ( matches($name, 'Type$') )
         then ()
         else $name
         
let $content :=
<div class="content">

Total Number of Named Structures = {count($distinct-names)}<br/>
Filtered Names (remove macro, att, model, TEI and body) = {count($sorted-filtered-names)}<br/>

<table class="span-20 last">
   <thead>
      <tr>
         <th class="span-1">#</th>
         <th class="span-3">Name</th>
         <th class="span-15">Definition</th>
         <th class="span-2 last">Element or Attribute</th>
         <th class="span-2 last">Types</th>
      </tr>
   </thead>
   <tbody>
       {for $name at $count in $sorted-filtered-names
        let $items := $schema//(xs:element|xs:attribute)[@name=$name]
        return
        <tr> {if ($count mod 2) then (attribute bgcolor {'Lavender'}) else ()}
           <td>{$count}</td>
           <td><a href="view-named-item.xq?name={$name}&amp;file={$file}">{$name}</a></td>
           
           <td>{$items//xs:documentation/text()} </td>
           <td>{for $item in $items return substring-after(name($item), 'xs:')}</td>
           <td>{for $item in $items return $item/@type/string()}</td>
        </tr>
       }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)