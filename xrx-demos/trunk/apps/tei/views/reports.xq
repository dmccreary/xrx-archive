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
       <span>Sample Reports for Play:</span> <i>{$title}</i>
       <ol>
          <li><a href="distinct-speakers.xq?id={$id}">Distinct Speakers</a></li>
          <li><a href="cast-list.xq?id={$id}">Cast List</a></li>
      </ol>
    </div>

return 
    style:assemble-page($content)
