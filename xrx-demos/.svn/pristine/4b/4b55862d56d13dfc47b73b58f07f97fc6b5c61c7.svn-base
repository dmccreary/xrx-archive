xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := 'View Project Information'

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

let $content :=
<div class="content">

   {let $item := collection($data-collection)/GeneralProject[id = $id]
      return
         <table>
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
             <tr><th class="field-label">Project Name:</th><td>{$item/ProjectName/text()}</td></tr>
             <tr><th class="field-label">Project Description:</th><td>{$item/ProjectDescriptionText/text()}</td></tr>
             
             <tr><th class="field-label">Project Description:</th><td>{$item/ProjectDescriptionText/text()}</td></tr>
             <tr><th class="field-label">Project Scope:</th><td>{$item/ProjectScopeText/text()}</td></tr>
             <tr><th class="field-label">Project Business Objectives:</th><td>{$item/ProjectBusinessObjectivesText/text()}</td></tr>
             <tr><th class="field-label">Project Implementation Stratagy:</th><td>{$item/ProjectImplementationStratagyText/text()}</td></tr>
             <tr><th class="field-label">Project Memo Of Understandings:</th><td>{$item/ProjectMemoOfUnderstandingsText/text()}</td></tr>
             
             
             <tr><th class="field-label">Project Sponsor:</th><td>{$item/ProjectSponsorUserID/text()}</td></tr>
             <tr><th class="field-label">Project Owner:</th><td>{$item/ProjectOwnerUserID/text()}</td></tr>
             <tr><th class="field-label">Project Contact:</th><td>{$item/ProjectContactUserID/text()}</td></tr>
             <tr><th class="field-label">Project Approver:</th><td>{$item/ProjectApproverUserID/text()}</td></tr>
             
             <tr><th  class="field-label">Project Roles:</th></tr>
             
             {for $role in $item/PersonRoles/Role
                return
                <tr>
                   <th class="field-label">Role: {$role/PersonRoleCode/text()}:</th>
                   <td>{$role/UserID/text()}</td>
                </tr>
             }
             
             <tr><th class="field-label">Project Status:</th><td>{$item/DevelopmentStatusCode/text()}</td></tr>
             
            
              <tr><th class="field-label">Project Requirements:</th></tr>
             {for $requirement in $item/Requirements/Requirement
                let $requirement-id := $requirement/RequirementID/text()
                return
                <tr>
                   <th class="field-label">Requirement ID: {$requirement-id}:</th>
                   <td>{$requirement/RequirementName/text()}
                   <a href="view-requirement.xq?id={$requirement-id}">View</a>
                   </td>
                </tr>
                 
             }
             </tbody>
             {style:revision-status-table($item)}
          </table>
             
   }
   
  
 
  
   <a href="../../requirements/views/list-items.xq?id={$id}">Add Requirement to This Project</a><br/>
   <a href="../../requirements/views/list-items.xq?id={$id}">Add Document to This Project</a><br/>
    
    {style:edit-controls($id)}

</div>
return style:assemble-page($title, $content)