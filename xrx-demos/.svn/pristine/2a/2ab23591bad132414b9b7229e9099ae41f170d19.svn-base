xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Get Comments from NIEM XML Schema Complex Types'

let $file := request:get-parameter('file', '/db/dma/apps/niem/schemas/niem/universal/1.0/universal.xsd')

(: open the XML Schema file and point to the root element :)
let $schema := doc($file)/xs:schema

(: create a sequence of all of the complex types in the file :)
let $named-items := ($schema//xs:complexType, $schema//xs:element)

let $content :=
<div class="content">
<span>File = {$file}</span>
<p>The following report select all of the complexTypes and xs:documentation elements from an XML Schema.</p>
    <table class="datatable span-24">
       <thead>
          <tr>
             <th class="span-4">Named </th>
             <th class="span-2">Type</th>
             <th class="span-12 last">Documentation</th>
          </tr>
       </thead>
       {for $named-type at $count in $named-items
         let $name := concat(string($named-type/@name), string($named-type/../@name))
         return
            <tr>
               {if ($count mod 2)
                  then attribute class {'odd'}
                  else attribute class {'even'}
               }
               <td><a href="view-named-item.xq?file={$file}&amp;name={$name}">{$name}</a></td>
               <td>{local-name($named-type)}</td>  
               <td>{$named-type//xs:documentation/text()}</td>  
            </tr>
       }
    </table>
</div>

return style:assemble-page($title, $content)
