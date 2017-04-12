xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Extract Complex Types, Documentation and Comments'

let $file := request:get-parameter('file', '/db/dma/apps/niem/schemas/niem/universal/1.0/universal.xsd')

let $sort := request:get-parameter('sort', 'document')

let $data-collection := $style:db-path-to-app-data

let $file-path := $file

(: check that the file is available :)
return if (not(doc-available($file-path))) then
   <error>
      <message>Document {$file-path} does not exist</message>
   </error>
else

let $schema := doc($file-path)/xs:schema

let $complex-types := $schema//xs:complexType

let $content :=
<div class="content">
<span>File = {$file}</span>
<p>The following is an extract of complex types and the XML annotation and XML comments
associated with each complex type.  Note that this report is in <b>document order</b>.</p>
    <table>
       <thead>
          <tr>
             <th>Type</th>
             <th>Compare</th>
             <th>Documentation</th>
             <th>Comments</th>
             <th>Sub Elements</th>
          </tr>
       </thead>
       {for $complex-type in $complex-types
         let $name := concat(string($complex-type/@name), string($complex-type/../@name))
         return
            <tr>
               <td><a href="view-named-item.xq?file={$file}&amp;name={$name}">{$name}</a></td>
               
               <td><a href="compare-named-item.xq?file1=SureScripts_Xml_4.21-guide.xsd&amp;file2=SureScripts_Xml_8.1e.xsd&amp;name={$name}">Compare</a></td>
               <td>{$complex-type//xs:documentation/text()}</td>
               <td>{for $comment in $complex-type/comment()
                    return
                     <b>{replace($comment, '--', '')}</b>}
               </td>
               <td>
                  <ol>{for $item in $complex-type/*/(xs:element/@name|comment())
                    return
                     
                        <li>
                        { if ( contains($item, '.') )
                            then <b>{string($item)}</b>
                            else replace($item, '--', '')
                        }
                        </li>
                     }
                  </ol>
               </td>
            </tr>
       }
    </table>
</div>

return style:assemble-page($title, $content)