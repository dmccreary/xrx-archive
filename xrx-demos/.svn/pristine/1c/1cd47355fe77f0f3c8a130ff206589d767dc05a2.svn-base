xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $id := request:get-parameter("id", "")

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc := concat($data-collection, '/', $id, '.xml')
let $title := 'item deleted' 
(: this script takes the integer value of the id parameter passed via get :)
let $id := xs:integer(request:get-parameter('id', ''))

(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: this constructs the filename from the id :)
let $file := concat($id, '.xml')

(: this deletes the file :)
let $store := xmldb:remove($data-collection, $file)

let $content :=
 <div class="content">
      <h1>User id {$id} has been removed.</h1>
     
   <div class="edit-controls">     
       <a href="../views/list-items.xq?id={$id}">List All Users</a>
       <a href="../index.xq?id={$id}">Main Menu</a>
   </div>
</div>

return style:assemble-page($title, $content)
