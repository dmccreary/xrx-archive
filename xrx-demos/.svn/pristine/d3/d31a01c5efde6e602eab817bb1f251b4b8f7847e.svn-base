xquery version "1.0";

import module namespace xsd2svg="http://danmccreary.com/xsd2svg" at "../modules/xml-schema-2-svg.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')

let $file := request:get-parameter('file', '')
let $debug := request:get-parameter('debug', '')

(: check for required parameters :)
return
if (not($file))
    then (
    <error>
        <message>Parameter "file" is missing.  This argument is required for this web service.</message>
    </error>)
    else

(: open the file :)
let $doc-path := concat('/db/dma/apps/schema-to-svg/data/', $file)
let $schema := doc($doc-path)/xs:schema

let $config :=
<config>
</config>

(:
 {if ($debug)
   then
   <debug>
      <file>{$file}</file>
      {$schema}
 </debug>
    else ()
 }
 :)
return

xsd2svg:main($schema)



