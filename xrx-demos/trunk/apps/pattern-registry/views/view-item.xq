xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'View Pattern'
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $name := request:get-parameter('name', '')
let $id := request:get-parameter('id', '')

let $pattern := if ($name)
   then collection($data-collection)/Pattern[PatternName=$name]
   else collection($data-collection)/Pattern[id=$id]
   

let $content :=
<div class="content">
      <table border="0">
            <tbody>
                <tr>
                    <th>Classifier:</th><td><a href="list-patterns-with-classifier.xq?classifier={$pattern/Classifier/text()}">{$pattern/Classifier/text()}</a></td>
                </tr>
                <tr>
                    <th>Name:</th><td>{$name}</td>
                </tr>
                <tr>
                    <th>Image:</th><td><img src="../images/{$pattern/Image/text()}"></img></td>
                </tr>
                <tr>
                    <th>Ref:</th><td><a href="{$pattern/Reference/text()}">Ref</a></td>
                </tr>
                <tr>
                    <th>Description:</th><td>{$pattern/Description/text()}</td>
                </tr>
                <tr>
                    <th>Question:</th><td>{$pattern/Question/text()}</td>
                </tr>
                <tr>
                    <th>Answer:</th><td>{$pattern/Answer/text()}</td>
                </tr>
                <tr>
                    <th>Note:</th><td>{$pattern/NoteText/text()}</td>
                </tr>
          </tbody>
      </table>

   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
</div>

return style:assemble-page($title, $content)

