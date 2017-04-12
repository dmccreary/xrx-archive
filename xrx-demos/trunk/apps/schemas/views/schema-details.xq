xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'XML Schema Details Report'

let $file := request:get-parameter('file', '')
let $query := request:get-parameter('query', '')

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

 if (not($query)) then 'Query query=$query is a required parameter' else

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema
let $full-query := concat('$schema//', $query)
let $elements := util:eval($full-query)

let $content :=
<div class="content">
<p>XML Schema Metrics Report for: <b>{$file}</b></p>

<p>Element Count = {count($elements)}</p>
<table class="span-14 last">
   <thead>
      <tr>
         <th class="span-8">Element</th>
         <th class="span-3">Metadata Registry</th>
         <th class="span-3">View XML</th>
      </tr>
   </thead>
   <tbody>
       {for $element in $elements
       let $name-str := concat(string($element/@name), string($element/@ref) )
       order by $name-str
       return
       if ($name-str)
           then
           <tr>
              <td>{$name-str}</td>
              <td><a href="../../apps/data-elements/view/view-element.xq?id={$name-str}">Metadata Registry</a></td>
              <td><a href="view-xml.xq?file={$file}&amp;name={$name-str}">View XML</a></td>
           </tr>
           else
           <tr>
              <td>{name($element)} - {string($element/@*)}{data($element)}</td>
           </tr>
       }
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)