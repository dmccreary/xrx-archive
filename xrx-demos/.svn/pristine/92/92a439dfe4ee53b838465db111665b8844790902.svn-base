xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'XML Schema Metrics'

let $file := request:get-parameter('file', '')

return if (not($file)) then 'URL Parameter file=$file is a required parameter' else

let $app-collection := '/db/surescripts/apps/schemas'

let $input-data-collection := concat($app-collection, '/data')
let $file-path := concat($input-data-collection, '/', $file)
let $schema := doc($file-path)/xs:schema

let $content :=
<div class="content">
<p>XML Schema Metrics Report for: <b>{$file}</b></p>
<table class="span-18 last">
   <thead>
      <tr>
         <th class="span-6">Metric</th>
         <th class="span-2">Count</th>
         <th class="span-10">Details</th>
      </tr>
   </thead>
   <tbody>
       <tr>
          <td>Nodes</td>
          <td>{count($schema//node())}</td>
       </tr>
       <tr>
          <td>Named Elements</td>
          <td>{count($schema//xs:element[@name])}</td>
       </tr>
       <tr>
          <td>Referenced Elements</td>
          <td>{count($schema//xs:element[@ref])}</td>
          <td><a href="schema-details.xq?file={$file}&amp;query=xs:element[@ref]">Details</a></td>
       </tr>
       <tr>
          <td>Attributes</td>
          <td>{count($schema//xs:attribute)}</td>
       </tr>
       
       <tr>
          <td>Complex Types</td>
          <td>{count($schema//xs:complexType)}</td>
       </tr>
       <tr>
          <td>Named Complex Types</td>
          <td>{count($schema//xs:complexType[@name])}</td>
          <td><a href="schema-details.xq?file={$file}&amp;query=xs:complexType">Details</a></td>

       </tr>
        <tr>
          <td>Simple Types</td>
          <td>{count($schema//xs:simpleType)}</td>
       </tr>
       
       <tr>
          <td>Named Simple Types</td>
          <td>{count($schema//xs:simpleType[@name])}</td>
          <td><a href="schema-details.xq?file={$file}&amp;query=xs:simpleType">Details</a></td>

       </tr>
       
       <tr>
          <td>Groups</td>
          <td>{count($schema//xs:group)}</td>
          <td><a href="schema-details.xq?file={$file}&amp;query=xs:group">Details</a></td>
       </tr>
       
       <tr>
          <td>Sequences</td>
          <td>{count($schema//xs:sequence)}</td>
       </tr>
       <tr>
          <td>Choices</td>
          <td>{count($schema//xs:choice)}</td>
       </tr>
       <tr>
          <th colspan="2">Required</th>
       </tr>
       
       <tr>
          <td>Required Elements (minOccurs = 1)</td>
          <td>{count($schema//xs:element[@minOccurs="1"])}</td>
       </tr>
       
       <tr>
          <td>Required Attributes (use=required)</td>
          <td>{count($schema//xs:attribute[@use="required"])}</td>
       </tr>
       
       <tr>
          <th colspan="3">Optional</th>
       </tr>
       
       <tr>
          <td>Optional Elements (minOccurs=0)</td>
          <td>{count($schema//xs:element[@minOccurs="0"])}</td>
       </tr>
       
       <tr>
          <td>Optional Attributes</td>
          <td>{count($schema//xs:attribute[not(@use) | @use="optional"])}</td>
       </tr>
       
       <tr>
          <th colspan="2">High Cardinality Elements</th>
       </tr>
       
       <tr>
          <td>Elements with Cardinality Greater Than 1</td>
          <td>{count($schema//xs:element[number(@maxOccurs) gt 1])}</td>
          <td>{ string-join($schema//xs:element[number(@maxOccurs) gt 1]/@maxOccurs, ', ') }</td>
       </tr>
       
       <tr>
          <th colspan="2">Restrictions</th>
       </tr>
       
       <tr>
          <td>Restrications</td>
          <td>{count($schema//xs:restriction)}</td>
       </tr>
       
       <tr>
          <td>Pattern Restrictions</td>
          <td>{count($schema//xs:pattern)}</td>
       </tr>
       
       <tr>
          <td>Enumeration Restrictions</td>
          <td>{count($schema//xs:enumeration)}</td>
          <td><a href="schema-details.xq?file={$file}&amp;query=xs:enumeration">Details</a></td>
       </tr>
       
       <tr>
          <td>Max Length Restrictions</td>
          <td>{count($schema//xs:maxLength)}</td>
       </tr>
       
   </tbody>
</table>
</div>

     
return
    style:assemble-page($title, $content)