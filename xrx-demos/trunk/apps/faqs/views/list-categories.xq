xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


let $doc := '/db/dma/apps/faqs/code-tables/faq-category-codes.xml'
let $title := 'List FAQ Categories' 
let $content :=
<div class="content">
   <table class="span-10">
       <thead>
       <tr>
          <th class="span-1">ID</th>
          <th>Category</th>
       </tr>
    </thead>
    <tbody>{
      for $item in doc($doc)/code-table/items/item
         let $id := $item/id/text()
      return
         <tr>
            <td>{$item/value/text()}</td>
            <td>{$item/label/text()}</td>
         </tr> 
   }</tbody>
   </table> 
</div>
return style:assemble-page($title, $content)