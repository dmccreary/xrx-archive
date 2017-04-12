xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace util2 = "http://surescripts.com/util2" at "../../../modules/util2.xqm";

let $title := 'List XML Schemas'

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $schemas := xmldb:get-child-resources($input-data-collection)

let $content :=
<div class="content">
<p>The following is a list of XML Schemas used to test the XML Schema to SVG module.</p>
<table class="span-23 last">
   <thead>
      <tr>
         <th class="span-4">File Name</th>
         <th class="span-2">Version</th>
         <th class="span-2">Names</th>
         <th class="span-2">Metrics</th>
         <th class="span-2">ID Types</th>
         <th class="span-3">XSD</th>
         <th class="span-2">Min</th>
         <th class="span-2">Max</th>
         <th class="span-8">Other Test Instances</th>
      </tr>
   </thead>
   <tbody>
    {
    for $schema in $schemas
    let $schema-end := util2:substring-after-last($schema, '_')
    let $schema-id := substring-before($schema-end, '.xsd')
    let $test-instance-collection := concat($input-data-collection, '/', $schema-id)
    let $min-file-path := concat($input-data-collection, '/', $schema-id, '/min.xml')
    let $max-file-path := concat($input-data-collection, '/', $schema-id, '/max.xml')
    let $files := 
       if (xmldb:collection-available($test-instance-collection))
          then (
                let $files := xmldb:get-child-resources($test-instance-collection)
                
                (: remove the min and max files from the other files :)
                let $position-of-min := index-of($files, 'min.xml')
                let $files2 := if ($position-of-min) then remove($files, $position-of-min) else ()
                
                let $position-of-max := index-of($files2, 'max.xml')
                let $files3 := if ($position-of-max) then remove($files2, $position-of-max) else ()
                
                return $files3
                )
          else ()
    
    order by $schema
    return
       <tr>
          <td>{$schema}</td>
          <td>{$schema-id}</td>
          <td><a href="schema-metrics.xq?file={$schema}">Metrics</a></td>
          <td><a href="named-schema-objects.xq?file={$schema}">Names</a></td>
          <td><a href="id-types.xq?file={$schema}">ID Types</a></td>
          <td><a href="../data/{$schema}">XSD</a></td>
          
          <td>{if (doc-available($min-file-path))
              then
                 <a href="validate.xq?file=min.xml&amp;schema={$schema-id}">Validate Min</a>
              else ()
              }
          </td>
          <td>{if (doc-available($max-file-path))
                then
                   <a href="validate.xq?file=max.xml&amp;schema={$schema-id}">Validate Max</a>
                else ()
          }</td>
          
          <td>
          {for $file in $files
           return
              (
              <a href="validate.xq?file={$file}&amp;schema={$schema-id}">{$file}</a>,
              ' ')
          }
          </td>
          
       </tr>
       
    }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)