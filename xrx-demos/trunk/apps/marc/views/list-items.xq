xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace marc="http://www.loc.gov/MARC21/slim";

let $title := 'List Marc Records'
let $path := '/db/dma/apps/marc/data/3marcrecords.xml'
let $doc := doc($path)/marc:collection
let $records := $doc//marc:record

let $content :=
<div class="content">
    Count = {count($records)}<br/>
    {for $record in $records
       return
         <li>{$record/marc:datafield[@tag="245"]/marc:subfield[@code="a"]/text()}</li>
    }
</div>

return style:assemble-page($title, $content)