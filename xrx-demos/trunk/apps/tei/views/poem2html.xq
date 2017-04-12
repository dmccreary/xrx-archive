xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../../modules/style.xqm";
import module namespace tei2html="http://xmlopenfoundation.org/poem2html" at "../modules/poem2html.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

(: TEI to HTML using Typeswitch XQuery Module :)

let $id := request:get-parameter('id', '')

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare/'
let $view-speakers := request:get-parameter('view-speakers', 'false')
(: let $play := collection($file-path)/TEI[@xml:id=$id] :)
let $id-suffix := substring-after($id, 'sha-')
let $file-path := concat($data-collection, $id-suffix, '.xml')
let $play := doc($file-path)
let $title := $play//teiHeader/fileDesc/titleStmt/title/text()

let $content :=
<div class="content">
<style type="text/css"><![CDATA[

.head {
   font-size: 1.5em;
   font-weight: bold;
}

]]></style>
       <h2>Title: {$title} </h2>
       {tei2html:main($play)}
       
      
      <p>File path: <a href="/rest{$file-path}">{$file-path}</a></p>
</div>

return 
    style:assemble-page($content)

