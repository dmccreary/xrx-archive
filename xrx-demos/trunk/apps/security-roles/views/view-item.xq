xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at "../../../modules/style.xqm";


declare function local:title-case($arg as xs:string?) as xs:string {
   concat(upper-case(substring($arg,1,1)), substring($arg,2))
             
 } ;
 
let $id := request:get-parameter('id', '')

let $title := 'View Security Role'

(: check for required parameters :)
return

if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $data-collection := $style:db-path-to-app-data
      let $item := collection($data-collection)/security-role[id = $id]
return
let $content := 
<div class="content">
 <table class="span-24">
    <thead>
       <tr>
          <th class="span-4">Field</th>
          <th class="span-20">Value</th>
       </tr>
    </thead>
    <tbody>{
    for $field in $item/element()
      return
         <tr>
             <td align="right" class="field-label">{local:title-case(name($field))}:</td>
             <td>{$field}</td>
         </tr>
     }</tbody>
  </table>

   
   
  {style:edit-controls($id)}
</div>

   return
        style:assemble-page($title, $content)
