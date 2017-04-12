xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'Confirm User Stories Deletion'

let $id := request:get-parameter("id", "")

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc := concat($data-collection, '/', $id, '.xml')

 let $content :=
 <div class="content">
    <h1>Are you sure you want to delete this User Story?</h1>
    <b>Name: </b>{doc($doc)/item/name/text()}<br/>
    <b>Path: </b> {$doc}
    <br/>
    <br/>
    <a class="warn" href="delete.xq?id={$id}">Yes - Delete This User Story?</a>
    <br/><br/> 
    <br/>
     <a  class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View User Stories)</a>
</div>

return style:assemble-page($title, $content)