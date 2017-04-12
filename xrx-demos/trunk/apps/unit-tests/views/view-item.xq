xquery version "1.0";

import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

let $title := 'View Unit Test Data'

let $id := request:get-parameter('id', '')
(: check for required parameters :)
return
   if (not($id)) then <error><message>Error - missing required parameter: id</message></error> else

let $app-collection := $style:db-path-to-app

let $data-collection := concat($app-collection, '/data')

let $unit-test := collection($data-collection)//unit-test[id/text() = $id]
let $batch-input-file := util:document-name($unit-test)
let $xsl := $unit-test/../header/xsl-file-name/text()
let $schema := $unit-test/../header/validation-schema/text()
let $source-schema := $unit-test/../header/source-schema/text()

let $transaction-type-code := $unit-test/transaction-type-code/text()
let $path-to-input-instance := $unit-test/input-file/text()
let $input-data-collection := '/db/surescripts/apps/xslt-test/data/input/'

let $input-path := concat($input-data-collection, $source-schema, '/', $transaction-type-code, '/', $path-to-input-instance)

let $link :=
   if ( not( doc-available($input-path)) )
   then 
      <div class="warn">Input document {$input-path} is not available.</div>
   else
      <a href="{request:get-context-path()}/rest{$input-path}">Input Instance</a>

let $content :=
<div class="content">

<b>Test ID: </b> {$id}<br/>

From Header:
<table class="span-17 last">
  <thead>
     <tr>
        <th class="span-6">Element</th>
        <th class="span-10">Value</th>
     </tr>
  </thead>
  <tbody>
    <tr>
       <td>Batch Input File</td>
       <td>{$batch-input-file}</td>
    </tr>
    <tr>
       <td>Source Schema</td>
       <td>{$source-schema}</td>
    </tr>
    <tr>
       <td>XML Tranform Used</td>
       <td>{$xsl}</td>
    </tr>
    <tr>
       <td>Validation XML Schema</td>
       <td>{$schema}</td>
    </tr>
   </tbody>
</table>

From Unit Test:
<table class="span-17 last">
  <thead>
     <tr>
        <th class="span-6">Element</th>
        <th class="span-10">Value</th>
     </tr>
  </thead>
  <tbody>
   {for $element in $unit-test/*
    let $name := name($element)
    return
    <tr>
       <td>{$name}</td>
       <td>{$element/text()}</td>
    </tr>
    }
   </tbody>
</table>
 {$link}
<a href="../scripts/transform.xq?id={$id}">Transform</a>
<a href="../scripts/transform-and-validate.xq?id={$id}">Validate Transform</a>
<br/>

<a href="../edit/edit.xq?id={$id}">Edit</a>

</div>

return style:assemble-page($title, $content)
