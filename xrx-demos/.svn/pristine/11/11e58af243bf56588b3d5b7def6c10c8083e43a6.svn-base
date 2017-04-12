xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace h = "http://danmccreary.com/help-manager" at "../modules/help-module.xqm";

declare namespace xhtml="http://www.w3.org/1999/xhtml";
let $id := request:get-parameter('id', '')

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
let $item := collection($data-collection)/help[id = $id]
let $code-table-items := doc(concat($app-collection, "/code-tables/category-codes.xml"))//item
let $code-table-items2 := doc(concat($app-collection, "/resource-type-codes.xml"))//item

    
let $title :='View Help'
 
let $content :=
<div class="content">
   
         <table class="item span-12">
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
             <tr><th class="field-label">Name:</th><td>{$item/name/text()}</td></tr>
             <tr><th class="field-label">Category:</th>
               <td>{$code-table-items[./value/text() = $item/category/text()]/label/text()}</td></tr>
             <tr><th class="field-label">Help Text:</th><td>{$item/help-text/text()}</td></tr> 
            
             </tbody>
          </table>
          
          {style:view-resources($item/resources)}
          {style:revision-status-table($item)}
          
               
     {style:edit-controls($id)} 

</div>

return 
    style:assemble-page($title, $content)