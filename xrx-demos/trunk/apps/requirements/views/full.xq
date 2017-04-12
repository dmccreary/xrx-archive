xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

import module namespace req='http://www.mnhs.org/requirements' at '../modules/requirements.xqm';


let $title := 'Active Requirements (full)'

(: Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $total-count := count(collection($data-collection)/Requirement)

let $content :=
<div class="content">
      <h3>{$title}</h3>

      Total Active Requirements = {$total-count}<br/>
{
         for $req in collection($data-collection)/Requirement
            let $id := $req/id/text()
            let $file := concat($data-collection, '/', $id, '.xml')
            let $requirement-name := $req/RequirementShortName/text()
            order by number($id)
         return
       <div class="requirement">
            <h2>Name: {$req/RequirementShortName/text()} (R{$req/id/text()})</h2>
     <table>
             <tbody>
              <tr><th class="field-label">Parent Requirement:</th><td>{req:id-to-name($req/RequirementParentID/text())} (R{$req/RequirementParentID/text()})</td></tr>
              <tr><th class="field-label">Description:</th><td>{$req/RequirementDescriptionText/text()}</td></tr>
              <tr><th class="field-label">Priority:</th><td>{$req/RequirementPriorityCode/text()}</td></tr>
              <tr><th class="field-label">Approval Status:</th><td>{$req/RequirementCompletionStatusCode/text()}</td></tr>
              <tr><th class="field-label">Approved By:</th><td>{$req/RequirementApprovedBy/text()}</td></tr>
              <tr><th class="field-label">Approval Date:</th><td>{$req/RequirementApprovalDate/text()}</td></tr>
              <tr><th class="field-label">Notes:</th><td>{$req/RequirementNoteText/text()}</td></tr>
              <tr><th class="field-label">Classifiers:</th><td>{string-join($req/RequirementClassifierCode/text(), ', ')}</td></tr>
              <tr><th class="field-label">Tags:</th><td>{string-join($req/RequirementTag/text(), ', ')}</td></tr>
              <tr><th class="field-label">Testable:</th><td>{$req/RequirementTestableCode/text()}</td></tr>
              <tr>
                 <th class="field-label">XML:</th>
                 <td>
             
                   
                     <a href="../edit/get-instance.xq?id={$id}">{$file}</a>
                    

                 </td>
              </tr>
              </tbody>
           </table>
          </div>
          }
</div>

return style:assemble-page($title, $content)