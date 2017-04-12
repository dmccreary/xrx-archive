xquery version "1.0";

(: Delete Item Confirmation :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', $id, '.xml')

let $content := 
    <div>
        <h1>Are you sure you want to delete this item?</h1>
        <b>Item ID: </b>{$id}<br/>
        <b>Path: </b> {$doc}
        <br/><br/>
        <a class="warn" href="delete?id={$id}">Yes - Delete This Item</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item?id={$id}">Cancel (Back to View Items)</a>
        <br/><br/><br/>
    </div>
    
return 
    style:assemble-page($content)