xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $app-id := request:get-parameter('app-id', '')
let $title := 'Publish to Web'

let $content :=
<div class="content">
  In an actual web content publishing system this page would confirm the publishing status on your public web site.
  <br/>
  <br/>
  Application ID = {$app-id}<br/>
  Item ID = {$id}<br/>
  <br/><br/>
</div>

return style:assemble-page($title, $content)
