xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare'

let $id := request:get-parameter('id', '')
let $id-suffix := substring-after($id, 'sha-')
let $play-id := substring($id-suffix, 1, 3)
let $act-number := xs:integer(substring($id-suffix, 4, 1))
let $scene-number := xs:integer(substring($id-suffix, 5, 2))
let $file-path := concat($data-collection, '/', $play-id, '.xml')
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
   { style:play-nav($doc) }
   <div class="span-19 last">

    <p>TEI file {$data-collection} SceneID: {$id}</p> 
    Title = {$doc/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()}<br/>
    Act = {$act-number}<br/>
    Scene = {$scene-number}
    
      {for $speaker at $speaker-count in $scene/tei:sp|$scene/tei:stage
      return
        if (name($speaker) = 'sp')
        then <div class="speech"><span class="speaker-label">{$speaker/tei:speaker/text()}:</span> {$speaker/tei:l/text()}</div>
        else <div class="stage"><b>Stage: </b>{$speaker/text()}</div>
      }
     
   </div>
</div>

return 
    style:assemble-page($content)