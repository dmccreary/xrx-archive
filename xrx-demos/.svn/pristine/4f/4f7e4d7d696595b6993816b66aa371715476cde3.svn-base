xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

(: base for this suite of applications :)
let $base := style:base-uri()
let $niem-query-path := concat(style:server-port(), '/exist/rest', $base, '/apps/niem/views/complex-picklist.xq')

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')

(: First get the NIEM conceptual data elements, then our own extensions. :)

let $niem-conceptual-data-elements := doc($niem-query-path)/codes/*

let $extension-conceptual-data-elements :=
   for $element-name in collection($data-collection)/DataElement
      [DataElementComplexIndicator='true']/DataElementName
         order by $element-name
      return <item><value>ex:{$element-name/text()}</value></item>

return
<CodeTable>
   <DataElementName>ObjectClassNameCode</DataElementName>
   {$niem-conceptual-data-elements}
   {$extension-conceptual-data-elements}
</CodeTable>
