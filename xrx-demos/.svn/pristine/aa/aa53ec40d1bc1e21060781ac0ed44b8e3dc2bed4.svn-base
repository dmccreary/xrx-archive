xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace mo="http://schemas.microsoft.com/office/mac/office/2008/main";
declare namespace ve="http://schemas.openxmlformats.org/markup-compatibility/2006";
declare namespace mv="urn:schemas-microsoft-com:mac:vml";
declare namespace o="urn:schemas-microsoft-com:office:office";
declare namespace r="http://schemas.openxmlformats.org/officeDocument/2006/relationships";
declare namespace m="http://schemas.openxmlformats.org/officeDocument/2006/math";
declare namespace v="urn:schemas-microsoft-com:vml";
declare namespace wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing";
declare namespace w10="urn:schemas-microsoft-com:office:word";
declare namespace w="http://schemas.openxmlformats.org/wordprocessingml/2006/main";
declare namespace wne="http://schemas.microsoft.com/office/word/2006/wordml";


let $title := 'OOXML Metrics'

let $file := request:get-parameter('file', 'uc-5.0-service-management-v2.1.xml')

let $app-collection := '/db/surescripts/apps/use-cases'
let $input-data-collection := concat($app-collection, '/data')
let $input-file-path := concat($input-data-collection, '/', $file)
let $doc := doc($input-file-path)/w:document

let $content :=
<div class="content">
   File Path: {$input-file-path}<br/>
   Nodes: {count($doc//node())}<br/>
   Text Nodes: {count($doc//w:t)}
   
   <ol>
   {for $text in $doc//w:t
     return
      <li>{$text}</li>}
      </ol>
</div>

return style:assemble-page($title, $content)