xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
return
<Requirements>
<Description>Requirment IDs and Names Sorted by RequirementName</Description>{
    for $req in collection($collection-path)/Requirement
       let $requirement-name := $req/RequirementShortName/text()
       order by $requirement-name
           return
       <Requirement>
          <RequirementID>{$req/RequirementID/text()}</RequirementID>
          <RequirementName>{$requirement-name}</RequirementName>
      </Requirement>
</Requirements>
