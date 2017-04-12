import module namespace sch-util='http://code.google.com/p/xrx/schema-util' at 'schema-utils.xqm';

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Unit Test for XML Schema Utilities'

let $data-collection := $style:db-path-to-app-data

let $sample-schema := 'Script_XML_8.1.xsd'

let $file-path := concat($data-collection, '/', $sample-schema)

let $schema := doc($file-path)/xs:schema

let $content :=
<div class="content">
   <table>
      <thead>
         <th>Test Name</th>
         <th>Result</th>
      </thead>
      <tbody>
         <tr>
             <td>isComplexName($schema, $name)</td>
             <td>{if (sch-util:isComplexName($schema, 'Body'))
                   then <span class="pass">PASS</span>
                   else <span class="fail">FAIL</span> 
                   }
            </td>
         </tr>
         
         <tr>
             <td>isComplexName($schema, $name)</td>
             <td>{if (sch-util:isComplexName($schema, 'Body'))
                   then <span class="pass">PASS</span>
                   else <span class="fail">FAIL</span> 
                   }
            </td>
         </tr>
         
      </tbody>
   </table>
</div>

return style:assemble-page($title, $content)
