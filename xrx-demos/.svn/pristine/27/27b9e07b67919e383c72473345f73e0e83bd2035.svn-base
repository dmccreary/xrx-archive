xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace u = "http://danmccreary.com/user-manager" at "../modules/user-module.xqm";

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
let $item := collection($data-collection)/user[id = $id]
let $title :='View User'
let $code-tables := doc(concat($app-collection, "/code-tables/user-role-codes.xml"))
let $sequence :=
  for $value in $item/roles/role/text()
    let $label := $code-tables//item[./value/text() = $value]/label/text()
    return $label
  
let $content :=
<div class="content">
   
         <table class="item span-10">
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
             <tr><th class="field-label">User ID (login-name):</th><td>{$item/user-id/text()}</td></tr>
             <tr><th class="field-label">Given Name:</th><td>{$item/person-given-name/text()}</td></tr>
             <tr><th class="field-label">Family Name:</th><td>{$item/person-family-name/text()}</td></tr>
             <tr><th class="field-label">Account Active:</th><td>{$item/account-active-indicator/text()}</td></tr>
             <tr><th class="field-label">Max Login Retrys:</th><td>{$item/max-login-retrys/text()}</td></tr>
             <tr><th class="field-label">Roles:</th><td>{string-join($sequence, ', ')}</td></tr>
             </tbody>
            
          </table>
          
             {style:revision-status-table($item)}
        
       {style:edit-controls($id)}
</div>

return 
    style:assemble-page($title, $content)