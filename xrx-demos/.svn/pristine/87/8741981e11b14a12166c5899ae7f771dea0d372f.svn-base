xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter("id", "")
let $title := 'Are you sure you want to delete this FAQ?'
let $app-collection := '/db/dma/apps/faqs'
let $doc := concat($app-collection, '/data/', $id, '.xml')

let $content :=
<div class="content">
        <b>Question: </b>{doc($doc)/faq/question/text()}<br/>
        <b>Path: </b> {$doc}
        <br/>
        <br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This FAQ</a>
        <br/>
        <br/>
        <br/>
         <a  class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View FAQ)</a>
</div>

return style:assemble-page($title, $content)