xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.tei-c.org/ns/1.0";


let $title := 'Play Structure'

let $id := request:get-parameter('id', '')

let $data-collection := $style:db-path-to-app-data
let $shakespeare := concat($data-collection, '/shakespeare/')
let $view-speakers := request:get-parameter('view-speakers', 'false')
(: let $play := collection($file-path)/TEI[@xml:id=$id] :)
let $id-suffix := substring-after($id, 'sha-')
let $file-path := concat($shakespeare, $id-suffix, '.xml')
let $play := doc($file-path)
(:let $title := $play//teiHeader/fileDesc/titleStmt/title/text():)

let $content :=
<div class="content">
       
       <ul>{
         for $act at $act-count in $play/TEI/text/body/div
            return
              <li><a href="view-act.xq?id={$id}{$act-count}">{$act/head/text()}</a>
                 <ul>
                  {for $scene at $scene-count in $act/div
                  return
                    <li><a href="view-scene.xq?id={$scene/@xml:id}">{substring-after($scene/head/text(), ',')}</a>
                    { if ($view-speakers = 'true')
                         then
                               <ul>
                                 {for $speaker at $speaker-count in $scene/sp
                                 return
                                   <li><a href="view-speaker.xq?id={$speaker/l/@xml:id}">{$speaker/speaker/text()}</a></li>
                                 }
                                </ul>
                          else ()
                     }
                     </li>
                  }
                 </ul>
              </li>
      }</ul>
      
      <p>File path: <a href="/rest{$file-path}">{$file-path}</a></p>
</div>

return 

    style:assemble-page($title, $content)
