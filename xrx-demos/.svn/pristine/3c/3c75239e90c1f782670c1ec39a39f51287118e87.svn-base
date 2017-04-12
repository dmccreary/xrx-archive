xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare/'
(: get all the act divs that have a head that start with the text 'Act' and that do not have a type attribute :)
let $scenes := collection($data-collection)/TEI/text/body/div/div[contains(head/text(), 'Scene')][not(@type)]

let $content :=
<div class="content">
       <h2>Add type attributes to Scenes divs</h2>
       <ol>{
         for $scene at $scene-count in $scenes
            let $id := $scene/@xml:id
            let $title := $scene/ancestor::TEI/teiHeader/fileDesc/titleStmt/title/text()
            let $update := update insert attribute type {"scene"} into $scene
            return
              <li>Adding Scene type to {$title} {' '} {$scene/head/text()}               
              </li>
      }</ol>
</div>

return 
    style:assemble-page($content)
