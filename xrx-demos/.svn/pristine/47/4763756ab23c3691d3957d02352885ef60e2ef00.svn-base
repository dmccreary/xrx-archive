xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $id := request:get-parameter('id', '')

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare/'
let $view-speakers := request:get-parameter('view-speakers', 'false')
(: let $play := collection($file-path)/TEI[@xml:id=$id] :)
let $id-suffix := substring-after($id, 'sha-')
let $file-path := concat($data-collection, $id-suffix, '.xml')
let $play := doc($file-path)
let $title := $play//teiHeader/fileDesc/titleStmt/title/text()

(: this says get all the speaker element, at any depth in the file :)
let $distinct-speakers := distinct-values($play//speaker/text())

return
let $content :=
<div class="content">
       <h2>Distinct Speakers Report</h2>
       <p>Distinct Speakers in {$title}</p>
       <ol>{
         for $speaker in $distinct-speakers
            order by $speaker
            return
              <li>{$speaker}</li>
      }</ol>
    </div>

return 
    style:assemble-page($content)
