xquery version "1.0";

let $title := 'Code Table Lookup'

let $value := request:get-parameter('value', '')

let $code-table-path := '/db/dma/apps/training/samples/05-code-table-lookup/publish-status-codes.xml'
let $code-table := doc($code-table-path)/code-table
let $items := $code-table//item

return
<results>
   <value>{$value}</value>
   <label>{$items[./value/text() = $value]/label/text()}</label>
</results>

