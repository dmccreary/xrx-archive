xquery version "1.0";

(: Delete Item Confirmation :)
import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")
let $title := 'Delete Confirmation'
let $data-collection := $style:db-path-to-app-data
let $doc := concat($data-collection, '/', $id, '.xml')

let $content := 
    <div>
        <h1>Are you sure you want to delete this security role?</h1>
        <b>Item ID: </b>{$id}<br/>
        <b>Name: </b>{doc($doc)//name/text()}<br/>
        <b>Path: </b> {$doc}
        <br/><br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Security Role</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View Security Role)</a>
        <br/><br/><br/>
    </div>
    
return 
    style:assemble-page($title, $content)
