xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $title := 'View Scene'

let $data-collection := $style:db-path-to-app-data
let $shakespeare := concat($data-collection, '/shakespeare')
let $id := request:get-parameter('id', '')
let $id-suffix := substring-after($id, 'sha-')
let $play-id := substring($id-suffix, 1, 3)
let $act-number := xs:integer(substring($id-suffix, 4, 1))
let $scene-number := xs:integer(substring($id-suffix, 5, 2))
let $file-path := concat($shakespeare, '/', $play-id, '.xml')
let $doc := doc($file-path)/tei:TEI

(: let $scene := collection($data-collection)//tei:div[@xml:id = $id] :)

let $scene := $doc//tei:text/tei:body/tei:div[$act-number]/tei:div[$scene-number]


let $content :=
<div class="content span-24">
    <style type="text/css"><![CDATA[
    
    .speaker-label {
       color: blue;
       font-weight: bold;
    }
    
    ]]></style>

   <div class="span-19 last">

    <p>TEI file {$shakespeare} SceneID: {$id}</p> 
    Title = {$doc/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()}<br/>
    Act = {$act-number}<br/>
    Scene = {$scene-number}
    
      {for $speaker at $speaker-count in $scene/tei:sp|$scene/tei:stage
      return
        if (name($speaker) = 'sp')
        then <div class="speech"><span class="speaker-label">{$speaker/tei:speaker/text()}:</span> {$speaker/(tei:l, tei:ab)/text()}</div>
        else <div class="stage"><b>Stage: </b>{$speaker/text()}</div>
      }
     
   </div>
</div>

return 
    style:assemble-page($title, $content)