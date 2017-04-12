xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

declare namespace functx = "http://www.functx.com";

declare function functx:is-node-in-sequence-deep-equal 
  ( $node as node()? ,
    $seq as node()* )  as xs:boolean {
       
   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
 } ;
 
declare function functx:distinct-deep 
  ( $nodes as node()* )  as node()* {
       
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(functx:is-node-in-sequence-deep-equal(
                          .,$nodes[position() < $seq]))]
 } ;

let $title := 'Documentation to Name'

let $file := request:get-parameter('file', 'Script_XML_8.1.xsd')

let $data-collection := $style:db-path-to-app-data

let $file-path := concat($data-collection, '/', $file)

let $schema := doc($file-path)/xs:schema

(: find all documentation tags that have a name :)
let $documentation := $schema//(xs:element[@name]|xs:complexType[@name])/xs:annotation/xs:documentation

let $distinct-documentation := functx:distinct-deep($documentation)

let $upper-case-only :=
   for $item in $distinct-documentation
   return
      if (matches($item/text(), '[a-z].*'))
        then ()
        else $item

let $sorted-items := 
    for $item in $upper-case-only
       order by $item/text()
       return
          $item
        
let $content :=
<div class="content">
<span>File = {$file}</span>
<p>The following is an extract of the first documentation elements within the XML Schema file {$file} when
the documentation elements are below a element or complexType that has a name attribute.
Only documentation without lower-case letters is returned.</p>
    Count = {count($upper-case-only)}
    <table class="span-10 last">
       <thead>
          <tr>
             <th  class="span-5">Documentation</th>
             <th  class="span-5 last">Element</th>
          </tr>
       </thead>
       {for $documentation at $count in $sorted-items
         order by normalize-space($documentation/text())
         return
            <tr>
               {if ($count mod 2) then (attribute {'bgcolor'} {'Lavender'}) else ()}

               <td>{$documentation/text()}</td>
               <td>{string($documentation/../../@name)}</td>
            </tr>
       }
    </table>
</div>

return
<results>
    <doc>
        {$documentation}
    </doc>
    <distinct>
        {$distinct-documentation}
    </distinct>
</results>