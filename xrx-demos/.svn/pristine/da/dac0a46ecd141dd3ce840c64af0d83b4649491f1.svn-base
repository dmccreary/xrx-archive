xquery version "1.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";

let $title := 'Validate XML Files in Input Collection'

(: this is the required fields :)
let $schema := request:get-parameter('schema', '')

(: check for required parameters :)
return
   if (not($file) or not($schema)) then <error><message>Error - missing required parameter</message></error> else

let $app-collection := '/db/surescripts/apps/schemas'
let $data-collection := concat($app-collection, '/data')

let $full-path := concat($data-collection, '/', $schema, '/', $file)

(: check to see if the input file exists :)
return
   if (not(doc-available($full-path)))
      then <error><message>Input Document {$full-path} is not available.</message></error>
      else

let $input-doc := doc($full-path)

let $schema-data-collection := '/db/surescripts/apps/schemas/data'
let $schema-uri := xs:anyURI(concat($schema-data-collection, '/SureScripts_Xml_', $schema, '.xsd'))

return
   if (not(doc-available($schema-uri)))
      then <error><message>XML Schema {$full-path} is not available</message></error> else

(: this must be run every time you change your XML Schema :)
let $clear := validation:clear-grammar-cache()

let $validation := validation:validate($input-doc, $schema-uri)

let $validation-report :=
    if ($validation)
       then 'PASS'
       else validation:validate-report($input-doc, $schema-uri)

return
<results>
   <title>{$title}</title>
   <input-file-path>{$full-path}</input-file-path>
   <input-node-count>{count($input-doc//node())}</input-node-count>
   <schema>{$schema}</schema>
   <schema-uri>{$schema-uri}</schema-uri>
   <validation>{$validation}</validation>
   <validation-report>{$validation-report}</validation-report>
</results>