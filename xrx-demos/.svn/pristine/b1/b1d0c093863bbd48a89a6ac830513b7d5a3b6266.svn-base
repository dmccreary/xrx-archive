xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util='http://code.google.com/p/xrx/schema-util' at '../modules/schema-utils.xqm';

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Compare Two XML Schemas'
let $file1 := request:get-parameter('file1', '')
let $file2 := request:get-parameter('file2', '')

return 
if (not($file1)) then
<error>
   <message>Error: The File Name parameter 'file1' is a required parameter.</message>
</error> else

if (not($file2)) then
<error>
   <message>Error: The File Name parameter 'file1' is a required parameter.</message>
</error> else

let $data-collection := $style:db-path-to-app-data
let $file-path1 := concat($data-collection, '/', $file1)
let $file-path2 := concat($data-collection, '/', $file2)
  
let $schema1 := doc($file-path1)/xs:schema
let $schema2 := doc($file-path2)/xs:schema

let $content :=
<div class="content">
   File 1 := {$file1}<br/>
   File 2 := {$file2}<br/>
   <table class="span-10 last">
      <thead>
         <tr>
            <th class="span-4">Metric</th>
            <th class="span-2">{sch-util:schema-id-from-file-name($file1)}</th>
            <th class="span-2 last">{sch-util:schema-id-from-file-name($file2)}</th>
         </tr>
      </thead>
      <tbody>
        <tr>
           <td>Node Count</td>
           <td>{sch-util:count-nodes($schema1)}</td>
           <td>{sch-util:count-nodes($schema2)}</td>
        </tr>
        <tr>
           <td>Named Items Count</td>
           <td>{sch-util:count-named-items($schema1)}</td>
           <td>{sch-util:count-named-items($schema2)}</td>
        </tr>
        <tr>
           <td>Named Complex Types</td>
           <td>{count($schema1//xs:complexType[@name])}</td>
           <td>{count($schema2//xs:complexType[@name])}</td>
        </tr>
        
      </tbody>
   </table>
   
   <h3>Other Reports</h3>
   <a href="compare-all-named-complex-types.xq?file1={$file1}&amp;file2={$file2}">Compare All Named Types</a><br/>
   <a href="compare-id-types.xq?file1={$file1}&amp;file2={$file2}">Compare ID Types</a>
</div>
return
    style:assemble-page($title, $content)