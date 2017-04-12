xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


let $id := request:get-parameter('id', '')
let $title := concat('View User Stories ', $id)

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
      let $item := collection($data-collection)/UseCase[id = $id]
      
let $content := 
    <div class="content">

         <table class="item span-12">
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
             <tr><th class="field-label">Name:</th><td>{$item/UseCaseName/text()}</td></tr>
             <tr><th class="field-label">Version:</th><td>{$item/UseCaseVersion/text()}</td></tr>
             <tr><th class="field-label">Goal:</th><td>{$item/UseCaseGoalText/text()}</td></tr>
             <tr><th class="field-label">Actor:</th><td>{$item/UseCaseActor/text()}</td></tr>
             <tr><th class="field-label">Preconditions:</th><td>{$item/UseCasePreconditionsText/text()}</td></tr>
             <tr><th class="field-label">Triggers:</th><td>{$item/UseCaseTriggersText/text()}</td></tr>
             <tr><th class="field-label">Events:</th><td>{$item/UseCaseEventsText/text()}</td></tr>
             
              <tr><th class="field-label">Alternate Paths:</th><td>{$item/UseCaseAlternatePaths/text()}</td></tr>
              <tr><th class="field-label">Postconditions:</th><td>{$item/UseCasePostconditions/text()}</td></tr>
              <tr><th class="field-label">Rules:</th><td>{$item/BusinessRulesText/text()}</td></tr>
              <tr><th class="field-label">Notes:</th><td>{$item/UseCaseNotesText/text()}</td></tr>
              <tr><th class="field-label">Author Name:</th><td>{$item/UseCaseAuthorName/text()}</td></tr>
              <tr><th class="field-label">Creation Date:</th><td>{$item/UseCaseCreationDate/text()}</td></tr>
              
             </tbody>
          </table>
          
        {style:revision-status-table($item)}
        
        {style:edit-controls($id)}
             
             
</div>

return 
    style:assemble-page($title, $content)