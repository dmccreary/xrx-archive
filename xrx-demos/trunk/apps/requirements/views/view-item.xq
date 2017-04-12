xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace req='http://www.mnhs.org/requirements' at '../modules/requirements.xqm';

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";


let $id := request:get-parameter('id', '')
let $title := concat('View Requirement ', $id)

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
          let $dp-path := concat('/exist/rest', substring-after($file, 'xmldb:exist://'))
          let $item := doc($file)/Requirement[id = $id]

let $content :=
<div class="content">
     <table>
        <tbody>
         <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
         <tr><th class="field-label">Parent ID:</th><td>{
           for $parent in $item/RequirementParentID/text()
           return
              <a href="view-item.xq?id={$parent}">{$parent}</a>, ' '
           }</td></tr>
         <tr><th class="field-label">Name Short Name:</th><td>{$item/RequirementShortName/text()}</td></tr>
         <tr><th class="field-label">Description:</th><td>{$item/RequirementDescriptionText}</td></tr>
         <tr><th class="field-label">Priority:</th><td>{$item/RequirementPriorityCode/text()}</td></tr>
         <tr><th class="field-label">Compleation Status:</th><td>{$item/RequirementCompletionStatusCode/text()}</td></tr>
         <tr><th class="field-label">Approved By:</th><td>{$item/RequirementApprovedBy/text()}</td></tr>
         <tr><th class="field-label">Approval Date:</th><td>{$item/RequirementApprovalDate/text()}</td></tr>
         <tr><th class="field-label">Notes:</th><td>{$item/RequirementNoteText/text()}</td></tr>
         <tr><th class="field-label">Classifiers:</th><td>{string-join($item/RequirementClassifierCode/text(), ', ')}</td></tr>
         <tr><th class="field-label">Tags:</th><td>{string-join($item/RequirementTag/text(), ', ')}</td></tr>
         <tr><th class="field-label">Testable:</th><td>{$item/RequirementTestableCode/text()}</td></tr>
         </tbody>
      </table>
      
      <table>
         <thead>
            <tr>
               <th>Label</th>
               <th>Type</th>
               <th>URL</th>
            </tr>
         </thead>
         <tbody>{
             for $resource in $item/Resources/Resource
             
             return
             <tr>
                <td>{$resource/ResourceLabelText/text()}</td>
                <td>{$resource/ResourceTypeCode/text()}</td>
                <td><a href="{$resource/ResourceURL/text()}">{$resource/ResourceURL/text()}</a></td>
            </tr>
         }</tbody>
      </table>
      
      <a href="hierarchy.xq?id={$id}">Hierarchy Report</a>
      
     {style:revision-status-table($item)}
     {style:edit-controls($id, "edpx")}
</div>

return style:assemble-page($title, $content)
