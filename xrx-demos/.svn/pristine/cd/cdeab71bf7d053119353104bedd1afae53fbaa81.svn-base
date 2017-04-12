xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View Student Record ', $id)

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
let $item := collection($data-collection)/student[id/text() = $id]
let $labs := $item//labs
let $content :=
<div class="content">
 <table class="span-12">
    <thead>
       <tr>
          <th class="span-3">Field</th>
          <th class="span-8 last">Value</th>
       </tr>
    </thead>
    <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">User ID:</th><td>{$item/user-id/text()}</td></tr>
     <tr><th class="field-label">First Name:</th><td>{$item/first-name/text()}</td></tr>
     <tr><th class="field-label">Last Name:</th><td>{$item/last-name/text()}</td></tr>
     </tbody>
  </table>

 <div class="labs">
      <div class="lab-title"><b>Labs:</b></div>
      <table class="span-12">
         <thead>
            <tr>
               <th class="span-3">Lab Number</th>
               <th class="span-8">Percent Complete</th>
            </tr>
         </thead>
         <tbody>{
            for $lab in $labs/lab
               return
               <tr>
                   <td>{$lab/lab-id/text()}</td>
                   <td>{$lab/progress-percent/text()}
                   
                   </td>
               </tr>
         }</tbody>
      </table>
   </div>
    {style:revision-status-table($item)}
   {style:edit-controls($id)}
   </div>


return style:assemble-page($title, $content)