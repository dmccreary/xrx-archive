xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare/'
(: get all the act divs that have a head that start with the text 'Act' and that do not have a type attribute :)
let $acts := collection($data-collection)/TEI/text/body/div[starts-with(head/text(), 'Act')][not(@type)]

let $content :=
<div class="content">
       <h2>Add type attributes to act divs</h2>
       <ol>{
         for $act at $act-count in $acts
            let $id := $act/@xml:id
            let $title := $act/ancestor::TEI/teiHeader/fileDesc/titleStmt/title/text()
            let $update := update insert attribute type {"act"} into $act
            return
              <li>Adding Scene Types to {$title} {' '} {$act/head/text()} </a>                
              </li>
      }</ol>
</div>

return 
    style:assemble-page($content)
