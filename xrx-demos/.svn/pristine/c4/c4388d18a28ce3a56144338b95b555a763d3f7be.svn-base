xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter("id", "")

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc := concat($data-collection, '/', $id, '.xml')
let $title :='Delete Confirmation'

let $content :=
<div class="contents">
<a href="../views/list-items.xq">List Items</a>
        <h1>Are you sure you want to delete this Item?</h1>
        <b>Name: </b>{doc($doc)/item/name/text()}<br/>
        <b>Path: </b> {$doc}
        <br/>
        <br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Project</a>
        <br/><br/>
        <br/>
         <a  class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View Project)</a>
</div>

return style:assemble-page($title, $content)
