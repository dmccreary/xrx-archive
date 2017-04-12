xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=yes indent=yes";

let $q := lower-case(request:get-parameter('q', ""))

let $collection := '/db/dma/apps/shop'
let $data-collection := concat($collection, '/data')

(: select all complex types that has a name attribute
let $complex := for $element in doc($niem-doc)/xs:schema/xs:complexType[contains(lower-case(@name),$q)]
      return
         <element>{substring-before(string($element/@name), 'Type')}</element>
 :)

let $simple :=
   for $element in collection($data-collection)//element
   [contains(lower-case(./name), $q) or  contains(lower-case(./definition), $q)]
      return
         $element
         
return
<results>
   <data-collection>{$data-collection}</data-collection>
   <q>{$q}</q>
   <count>{count($simple)}</count>
   {$simple}
</results>

