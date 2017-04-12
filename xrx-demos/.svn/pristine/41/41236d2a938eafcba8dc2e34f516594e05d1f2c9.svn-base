xquery version "1.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

let $title := 'Transform, Validate and Store'

(: these all are required fields :)
let $id := request:get-parameter('id', '')
let $debug := request:get-parameter('debug', 'true')

(: check for required parameters :)
return
   if (not($id)) then <error><message>Error - missing required parameter: id</message></error> else

let $data-collection := $style:db-path-to-app-data
let $unit-test := collection($data-collection)//unit-test[id=$id]

let $input-file := $unit-test/input-file/text()

(: get the information from the batch header :)
let $xsl := $unit-test/../header/xsl-file-name/text()
let $source-schema := $unit-test/../header/source-schema/text()

(: get the information from the unit test itself :)
let $transaction-type-code := $unit-test/transaction-type-code/text()
let $expected :=
    if ($unit-test/expected/text() = 'valid') then true() else false()

let $input-data-collection := '/db/surescripts/apps/xslt-test/data/input/'
let $input-path := concat($input-data-collection, $source-schema, '/', $transaction-type-code, '/', $input-file)
(: check if the input file exists :)
return
   if ( not( doc-available($input-path)) )
   then <error><message>Input document {$input-path} is not available.</message></error> else

let $xsl-data-collection := '/db/surescripts/apps/xslt-test/data/xslt'
let $xsl-path := concat($xsl-data-collection, '/', $xsl)
(: check if XSL file exists :)
return
   if ( not( doc-available($xsl-path)) )
   then <error><message>XSL document {$xsl-path} is not available.</message></error> else
   
let $output-collection := concat($data-collection, '/output/', $schema, '/', $transaction-type-code)

let $input-doc := doc($input-path)
let $xsl-doc := doc($xsl-path)

let $transform-out := transform:transform($input-doc, $xsl-doc, () )

return
<results>
   {if ($debug) then
   <div class="debug">
      {$unit-test}

      <input>{$input-path}</input>
   </div> else()}
   <transformation-output>{$transform-out}</transformation-output>
</results>