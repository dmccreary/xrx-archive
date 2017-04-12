xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util='http://code.google.com/p/xrx/schema-util' at '../modules/schema-utils.xqm';

let $title := 'Comparison Grid for XML Schemas'

let $app-collection := $style:db-path-to-app
let $input-data-collection := concat($app-collection, '/data')
let $schemas := xmldb:get-child-resources($input-data-collection)

let $ss-schemas :=
   for $schema in $schemas
   let $lc-name := lower-case($schema)
   order by sch-util:schema-id-from-file-name($schema)
   return
      if (starts-with($lc-name, 's') and contains($schema, 'XML'))
      then $schema
      else ()
 
let $content :=
<div class="content">
  <table class="span-23">
     <thead>
       
        <tr>
           <th bgcolor="blue">From</th>
           { for $schema1 in $ss-schemas
             let $schema-id := sch-util:schema-id-from-file-name($schema1)
             return
                <th class="span-4">{$schema-id}</th>
           }
        </tr>
     </thead>
     <tbody>{
         for $schema2 at $count2 in $ss-schemas
           let $schema-id2 := sch-util:schema-id-from-file-name($schema2)

        
        return
           <tr>
           <th>{$schema-id2}</th>
           {
           for $schema1 at $count1 in $ss-schemas
                let $schema-id1 := sch-util:schema-id-from-file-name($schema1)
                return
                   if
                      ($count1 ne $count2)
                      then
                         <td>
                            <a href="compare-schemas.xq?file1={$schema1}&amp;file2={$schema2}">{$schema-id1} vs {$schema-id2}</a>
                         </td>
                      else <td/>
           }</tr>
        }
     </tbody>
  </table>
</div>

return
    style:assemble-page($title, $content)