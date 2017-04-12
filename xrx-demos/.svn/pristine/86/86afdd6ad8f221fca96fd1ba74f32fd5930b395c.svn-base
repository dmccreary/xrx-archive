xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";


let $title := 'View Acts'

let $id := request:get-parameter('id', '')

let $data-collection := $style:db-path-to-app-data
let $shakespeare := concat($data-collection, '/shakespeare')
(: get the act ID from the URL paramger :)
let $id := request:get-parameter('id', '')
let $view-speakers := request:get-parameter('view-speakers', 'false')


let $id-suffix := substring-after($id, 'sha-')
let $play-id := substring($id-suffix, 1, 3)
let $act-number := substring($id-suffix, 4, 4)
let $file-path := concat($shakespeare, '/', $play-id, '.xml')
let $doc := doc($file-path)/tei:TEI

(: this should work let $act := collection($data-collection)//tei:div[@xml:id = $id] :)
let $act := $doc//tei:text/tei:body/tei:div[$act-number]

let $count := count($act/*)
let $doc-count := count($doc/tei:text/tei:body/tei:div)

let $content :=
<div class="content">
   Title = {$doc/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()}<br/>
   Act = {$act-number}
   
     <ol>
      {for $scene at $scene-count in $act/tei:div
      return
        <li><a href="view-scene.xq?id={$scene/@xml:id}">{$scene/tei:head/text()}</a>
        { if ($view-speakers = 'true')
        then
            <ol>
              {for $speaker at $speaker-count in $scene/tei:sp
              return
                <li><a href="view-speaker.xq?id={$speaker/l/@xml:id}">{$speaker/tei:speaker/text()}</a></li>
              }
             </ol>
         else ()
         }
         </li>
      }
     </ol>
</div>

return 
    style:assemble-page($title, $content)