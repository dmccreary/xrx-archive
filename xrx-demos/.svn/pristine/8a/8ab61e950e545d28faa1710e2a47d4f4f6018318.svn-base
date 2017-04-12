xquery version "1.0";

declare namespace transform="http://exist-db.org/xquery/transform";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $input-data :=
<root>
</root>

let $xslt := doc('/db/mdr/rules/schematron/xslt/hello-world.xsl')

let $results := transform:transform($input-data, $xslt, <parameters/>)
return
<transform-results>
   <input>{$input-data}</input>
   <xslt>{$xslt}</xslt>
   <output>{$results}</output>
</transform-results>