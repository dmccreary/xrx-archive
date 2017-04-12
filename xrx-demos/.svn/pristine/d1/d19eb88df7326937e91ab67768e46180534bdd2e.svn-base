xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'View Named XML Schema Structures'

let $file := request:get-parameter('file', 'teilite.xsd')
let $name := request:get-parameter('name', '')

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

 if (not($name)) then 'URL Parameter=$name is a required parameter' else

let $app-collection := $style:db-path-to-app

let $input-data-collection := concat($app-collection, '/tei-lite')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema
let $elements := $schema//*[@name=$name]

return
<results>
  <description>All XML Schema items with name={$name} in file={$file}</description>
       {for $element in $elements
       return
           $element
       }
</results>