xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $id := request:get-parameter("id", "")

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc := concat($data-collection, '/', $id, '.xml')
let $title := 'Help Item Deleted' 
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
      <h4>Help Item {$id} has been removed.</h4>
  </div>

return style:assemble-page($title, $content)
