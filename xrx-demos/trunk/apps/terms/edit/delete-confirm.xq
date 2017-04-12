xquery version "1.0";

(: Delete Item Confirmation :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")

let $title := concat('Delete Confirmation for ', $id)

let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', $id, '.xml')

let $content := 
<div class="content">
    <div>
        <h1>Are you sure you want to delete this term?</h1>
        <b>Item ID: </b>{$id}<br/>
        <b>Path: </b> {$doc}
        <br/><br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Term</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View Term)</a>
        <br/><br/><br/>
    </div>
    </div>
    
return 
    style:assemble-page($title, $content)