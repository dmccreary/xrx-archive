xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Documentation to Name'

let $file := request:get-parameter('file', 'Surescripts_XML_8.1.xsd')

let $data-collection := $style:db-path-to-app-data

let $file-path := concat($data-collection, '/', $file)

let $schema := doc($file-path)/xs:schema

(: find all documentation that have a name :)
let $documentation := $schema//(xs:element[@name]|xs:complexType[@name])//xs:documentation/text()

let $distinct-documentation := distinct-values($documentation)

let $upper-case-only :=
   for $item in $distinct-documentation
   return
      if (matches($item, '[a-z].*'))
        then ()
        else $item

let $content :=
<div class="content">
<span>File = {$file}</span>
<p>The following is an extract of all elements within the XML Schema file {$file}.</p>
    Count = {count($upper-case-only)}
    <table>
       <thead>
          <tr>
             <th>Documentation</th>
             <th>Element</th>
             <th>Comments</th>
          </tr>
       </thead>
       {for $documentation in $upper-case-only

         order by $documentation
         return
            <tr>
               <td>{$documentation}</td>
               
               
            </tr>
       }
    </table>
</div>

return style:assemble-page($title, $content)