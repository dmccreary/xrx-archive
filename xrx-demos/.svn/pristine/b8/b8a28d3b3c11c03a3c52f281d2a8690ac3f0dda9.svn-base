xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Compare Named XML Schema Structures'

let $file1 := request:get-parameter('file1', '')
let $file2 := request:get-parameter('file2', '')
let $name := request:get-parameter('name', '')

(:
return if (not($file1)) then 'URL Parameter file1=$file1 is a required parameter' else
 if (not($file1)) then 'URL file2=$file2 is a required parameter' else
 if (not($name)) then 'URL name=$name is a required parameter' else
 :)

let $input-data-collection := $style:db-path-to-app-data

let $file-path1 := concat($input-data-collection, '/', $file1)
let $file-path2 := concat($input-data-collection, '/', $file2)

let $schema1 := doc($file-path1)/xs:schema
let $schema2 := doc($file-path2)/xs:schema

let $elements1 := $schema1//*[@name=$name]
let $elements2 := $schema2//*[@name=$name]
let $md5-1 := util:hash(<nodes>{$elements1}</nodes>, 'MD5')
let $md5-2 := util:hash(<nodes>{$elements2}</nodes>, 'MD5')

return
<results>
  <title>{$title}</title>
     <name>{$name}</name>
     <file-1>
        <file-name>{$file1}</file-name>
        <node-count>{count($schema1//node())}</node-count>
     </file-1>
     <file-2>
        <file-name>{$file2}</file-name>
        <node-count>{count($schema2//node())}</node-count>
     </file-2>
     
  <description>All XML Schema items with name={$name} in file1=</description>
  {if ($md5-1 = $md5-2) then <comparison>Same</comparison>
  else
  <different>
    <file1>
        
         {for $element in $elements1
         return
             $element
         }
    </file1>
    <file2>
         
         {for $element in $elements2
         return
             $element
         }
    </file2>
  </different>}
</results>