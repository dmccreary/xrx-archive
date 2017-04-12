xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $title := 'View Play'

let $id := request:get-parameter('id', '')

let $data-collection := $style:db-path-to-app-data
let $shakespeare :=concat($data-collection, '/shakespeare')
(: get the act ID from the URL parameter :)
let $id := request:get-parameter('id', '')
let $view-speakers := request:get-parameter('view-speakers', 'false')

let $id-suffix := substring-after($id, 'sha-')
let $play-id := substring($id-suffix, 1, 3)
let $act-number := substring($id-suffix, 4, 4)
let $file-path := concat($shakespeare, '/', $play-id, '.xml')
let $doc := collection($data-collection)/tei:TEI[@xml:id = $id]

(: this should work let $act := collection($data-collection)//tei:div[@xml:id = $id] :)
let $acts := $doc//tei:div[@type='act']

let $act-count := count($acts)

let $content :=
<div class="content">
   Title = {$doc//tei:fileDesc/tei:titleStmt/tei:title/text()}<br/>
   Author = {$doc//tei:fileDesc/tei:titleStmt/tei:author/text()}<br/>
   Acts = {$act-count}
   
     <ol>
      {for $act at $act-count in $acts
      return
        <li><a href="view-act.xq?id={$act/@xml:id}">{$act/tei:head/text()}</a>
       
        </li>
      }
     </ol>
</div>

return 
    style:assemble-page($title, $content)