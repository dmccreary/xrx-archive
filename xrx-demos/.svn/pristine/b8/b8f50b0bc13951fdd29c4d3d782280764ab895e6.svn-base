xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace train = "http://www.danmccreary.com/training" at "../modules/training.xqm";

let $id := request:get-parameter('id', '')
let $title := concat('Review Quiz ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data/review-quizes')
let $review-quiz := collection($data-collection)//review-quiz[./id/text() = $id]

let $content :=
<div class="content">
 Quiz Description: {$review-quiz/desc/text()}
 <br/><br/><br/>
 
 <a href="{$review-quiz/url/text()}">Take the Quiz Now</a>
 
 <br/><br/><br/>
   <!--
   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
   -->
</div>

return style:assemble-page($title, $content)