xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $total-count := count(collection($data-collection)/Requirement)

return
<Requirements>{
for $req in collection($data-collection)/Requirement
    let $id := $req/id/text()
    let $requirement-name := $req/RequirementShortName/text()
    order by $requirement-name
 return $req
}</Requirements>