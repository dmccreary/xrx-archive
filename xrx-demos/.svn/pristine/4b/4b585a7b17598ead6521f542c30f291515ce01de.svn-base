xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := number(request:get-parameter('id', ''))
let $title := concat('View item ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $item := collection($data-collection)//record[$id]

let $content :=
<div class="content">
 <table class="span-12">
  <thead>
       <tr>
          <th class="span-3">Field</th>
          <th class="span-9 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">Sales Order Number:</th><td>{$item/sonum/text()}</td></tr>
     <tr><th class="field-label">Company Name:</th><td>{$item/dname/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/ename/text()}</td></tr>
   </tbody>
  </table>

   <a href="../edit/edit.xq?id={$id}">Edit</a>
</div>

return style:assemble-page($title, $content)