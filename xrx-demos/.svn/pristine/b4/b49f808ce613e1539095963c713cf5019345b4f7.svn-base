xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sch-util='http://code.google.com/p/xrx/schema-util' at '../modules/schema-utils.xqm';

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Compare ID Types'
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

let $complexIDTypes1 := $schema1//xs:complexType[ends-with(@name, 'IDType')]
let $complexIDTypes2 := $schema2//xs:complexType[ends-with(@name, 'IDType')]

let $all-names := distinct-values( ($complexIDTypes1, $complexIDTypes2)/@name )

let $sort-names :=
  for $name in $all-names
  order by $name
  return $name

let $content :=
<div class="content">
   File 1 := {$file1}<br/>
   File 2 := {$file2}<br/>
   Total Named IDTypes = {count($all-names)} which are all complex types with the name suffix "IDType".
   
   <table class="span-12 last">
      <thead>
         <tr>
            <th class="span-4">Metric</th>
            <th class="span-4">{$file1}</th>
            <th class="span-4 last">{$file2}</th>
         </tr>
      </thead>
      <tbody>
        <tr>
           <td>Complex ID Types</td>
           <td>{count($complexIDTypes1)}</td>
           <td>{count($complexIDTypes1)}</td>
        </tr>
      </tbody>
   </table>
   
   {for $name in $sort-names
      (: this returns a sequence of element names in the null namespage
        <element-names>
            <element>ContractNumber</element>
         </element-names>
      :)
      let $elements1 := sch-util:element-names-for-complex-type($complexIDTypes1[@name=$name])
      let $elements2 := sch-util:element-names-for-complex-type($complexIDTypes2[@name=$name])
      let $md5-1 := util:hash($elements1, 'MD5')
      let $md5-2 := util:hash($elements2, 'MD5')
   return
   <div class="complexType">
      <h3>{$name}</h3>
      
      {if ($md5-1 = $md5-2)
      then <div class="success">The sorted element list of the complex types are identical</div>
      else
         if (count($elements1/element) = 0)
         then <div class="no-left">The type does not exist in {$file1}.<br/>
         The following sub-elements exist in {$file2}:
              <ol>{
                for $element-name in $elements2//element/text()
                return
                   <li>{$element-name}</li>
              }</ol>
              </div>
         else if (count($elements2/element) = 0)
            then <div>The type does not exist in {$file2}.<br/>
         The following sub-elements exist in {$file1}:
              <ol>{
                for $element-name in $elements1//element/text()
                return
                   <li>{$element-name}</li>
              }</ol>
              </div>
         else
      <table class="span-15 last">
         <thead>
            <tr>
               <th class="span-5">{$file1}</th>
               <th class="span-5">Both</th>
               <th class="span-5 last">{$file2}</th>
            </tr>
         </thead>
         {sch-util:diff-sequences-to-table-rows($elements1//element, $elements2/element)}
      </table>
      }
   </div>
   }
   
   <h3>Other Reports</h3>
   
</div>
return
    style:assemble-page($title, $content)