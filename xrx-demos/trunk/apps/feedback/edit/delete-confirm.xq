xquery version "1.0";

(: Delete Item Confirmation :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', $id, '.xml')
let $title :="Are you sure you want to Delete this feedback item?"
let $content := 
    <div>
        <b>Item ID: </b>{$id}<br/>
        <b>Path: </b> {$doc}
        <br/><br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Feedback Item</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View Feedback Item)</a>
        <br/><br/><br/>
    </div>
    
return style:assemble-page($title, $content)