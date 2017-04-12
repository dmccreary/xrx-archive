xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'View Named ID Types'

let $file := request:get-parameter('file', '')
let $format := request:get-parameter('format', 'html')

(: error checking :)

(: check for required parameter :)
return if (not($file)) then 
   <error>
      <message>URL Parameter file is a required parameter'</message> else
   </error>
else

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $file-path := concat($input-data-collection, '/', $file)

(: check that the file is available :)
return if (not(doc-available($file-path))) then
   <error>
      <message>Document {$file-path} does not exist</message>
   </error>
else

let $schema := doc($file-path)/xs:schema
let $complexTypes := $schema//xs:complexType[ends-with(@name, 'IDType')]

return
if ($format = 'xml')
    then
        <results>
          <description>All XML Schema items that end in 'IDType' in file={$file}</description>
               {for $complexType in $complexTypes
               return
                   $complexType
               }
        </results>
else
let $content :=
<div class="content">
   File = {$file}<br/>
   {for $complexType in $complexTypes
   let $name := string($complexType/@name)
   order by $name
   return
   <div class="complexType">
      
               
      <h5>{$name}</h5>
      <ol>
      {for $element in $complexType/xs:choice/xs:element
               return
               <li>{string($element/@name)}</li>
       }
      </ol>
    </div>
    }
</div>
return style:assemble-page($title, $content)
