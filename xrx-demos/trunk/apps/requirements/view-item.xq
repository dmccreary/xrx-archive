xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'View Requirement'
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
          let $file := concat($data-collection, '/', $id, '.xml')
          let $item := doc($file)/Requirement[id = $id]

let $content :=
<div class="content">
   <h1>{concat($title, ' ', $id)}</h1>
     <table>
        <tbody>
         <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
         <tr><th class="field-label">Parent ID:</th><td>{$item/RequirementParentID/text()}</td></tr>
         <tr><th class="field-label">Name Short Name:</th><td>{$item/RequirementShortName/text()}</td></tr>
         <tr><th class="field-label">Description:</th><td>{$item/RequirementDescriptionText/text()}</td></tr>
         <tr><th class="field-label">Name Short Name:</th><td>{$item/RequirementShortName/text()}</td></tr>
         <tr><th class="field-label">Priority:</th><td>{$item/RequirementPriorityCode/text()}</td></tr>
         <tr><th class="field-label">Compleation Status:</th><td>{$item/RequirementCompletionStatusCode/text()}</td></tr>
         <tr><th class="field-label">Approved By:</th><td>{$item/RequirementApprovedBy/text()}</td></tr>
         <tr><th class="field-label">Approval Date:</th><td>{$item/RequirementApprovalDate/text()}</td></tr>
         <tr><th class="field-label">Notes:</th><td>{$item/RequirementNoteText/text()}</td></tr>
         <tr><th class="field-label">Classifiers:</th><td>{string-join($item/RequirementClassifierCode/text(), ', ')}</td></tr>
         <tr><th class="field-label">Tags:</th><td>{string-join($item/RequirementTag/text(), ', ')}</td></tr>
         <tr><th class="field-label">Testable:</th><td>{$item/RequirementTestableCode/text()}</td></tr>
         <tr>
            <th class="field-label">XML:</th>
            <td>
               <a
               href="{concat('/exist/rest', $file)}">
               {$file}
            </a>
            </td>
         </tr>
         </tbody>
      </table>
      
      {style:revision-status-table($item)}
      
          <div>
              <a href="../edit/edit.xq?id={$id}">Edit Item</a>
              <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
           </div>
</div>

return style:assemble-page($title, $content)
