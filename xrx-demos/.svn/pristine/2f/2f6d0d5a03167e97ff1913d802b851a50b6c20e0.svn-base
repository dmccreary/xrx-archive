xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';

(: search for all the data element candidates in the metadata shopper :)
let $data-element-collection := '/db/dma/apps/data-elements/data'

let $id := request:get-parameter("q", "") 
let $record :=($id)

return
<search-results>{
    for $record in collection($data-element-collection)/DataElement[fn:matches($record/*, $id, "i")]
    return 
    <hit>
        <element>{$record/DataElementName/text()}</element>
        <definition>{$record/DataElementDefinitionText/text()}</definition>
   </hit>
}</search-results>