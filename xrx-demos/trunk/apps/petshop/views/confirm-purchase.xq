xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $role := request:get-parameter('role', '')

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

let $item := collection($data-collection)/animal[id/text() = $id]

let $content :=
<div class="content">
<h1>Are you sure you want to purchase this pet?</h1>

<br/><br/>
<a class="warn" href="../edit/purchase.xq?id={$id}">Yes - Really Purchase</a>
<br/><br/><br/>
<a class="cancel" href="../views/view-item?id={$id}">Cancel (Back to View Animal)</a>
<br/><br/>

 <table class="span-10">
    <thead>
       <tr>
          <th class="span-2">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Category:</th><td>{$item/animal-category-code/text()}</td></tr>
     <tr><th class="field-label">Type:</th><td>{$item/animal-type-code/text()}</td></tr>
     <tr><th class="field-label">Name:</th><td>{$item/animal-name/text()}</td></tr>
     <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
     <tr><th class="field-label">Price:</th><td>{$item/pruchase-amount/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
     <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
     </tbody>
  </table>
  
  <img src="../images/{$item/image/text()}"/>

   {if ($role = 'store-admin')
   then
   <div class="edit-controls">
      <a href="../edit/edit.xq?id={$id}">Edit Item</a>
      <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
   </div>
   else
   <div class="edit-controls">
      <a href="../edit/purchase.xq?id={$id}">Purchese Item</a>
   </div>
   }
</div>

return style:assemble-page($title, $content)