xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')

(: Mark Item as have been purchased. :)

let $title := concat('Purchase Confirmation for Animal id=', $id)

let $content :=
<div>
   <p>This page would confirm that you have purchase animal id = {$id}.<br/>
   
   If this was a real
   application this would have redirected you to a page that gathers name and payment information.
   </p>
</div>

return style:assemble-page($title, $content)