xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Extract Named Elements, Documentation and Comments'

let $file := request:get-parameter('file', 'Surescripts_XML_8.1.xsd')

let $data-collection := $style:db-path-to-app-data

let $file-path := concat($data-collection, '/', $file)

(: check that the file is available :)
return if (not(doc-available($file-path))) then
   <error>
      <message>Document {$file-path} does not exist</message>
   </error>
else

let $schema := doc($file-path)/xs:schema

(: find all elements that have a name :)
let $elements := $schema//xs:element[@name]

let $content :=
<div class="content">
<span>File = {$file}</span>
<p>The following is an extract of all elements within the XML Schema file {$file}.</p>
    Count = {count($elements)}
    <table>
       <thead>
          <tr>
             <th>Element</th>
             <th>Documentation</th>
             <th>Comments</th>
          </tr>
       </thead>
       {for $element in $elements
         let $name := string($element/@name)
         order by $name
         return
            <tr>
               <td><a href="view-named-item.xq?file={$file}&amp;name={$name}">{$name}</a></td>
               <td>{$element//xs:documentation/text()}</td>
               <td>{for $comment in $element/comment()
                    return
                     <b>{replace($comment, '--', '')}</b>}
               </td>
               
            </tr>
       }
    </table>
</div>

return style:assemble-page($title, $content)