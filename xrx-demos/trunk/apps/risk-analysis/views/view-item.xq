xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title := concat('View Risk ', $id)

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
let $item := collection($data-collection)/Risk[id/text() = $id]
let $code-tables := doc(concat($app-collection, '/code-tables/risk-status-codes.xml'))/code-table
let $code-tables2 := doc(concat($app-collection, '/code-tables/plan-status-codes.xml'))/code-table   

let $sequence :=
  for $value in $item//RiskStatus/text()
    let $label := $code-tables//item[./value/text() = $value]/label/text()
    return $label
    
let $sequence2 :=
  for $value in $item//RiskPlan/text()
    let $label2 := $code-tables2//item[./value/text() = $value]/label/text()
    return $label2
  
let $content :=
<div class="content">
 <table class="span-12">
  <thead>
       <tr>
          <th class="span-3">Field</th>
          <th class="span-9 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
     <tr><th class="field-label">Project ID:</th><td>{$item/Projectid/text()}</td></tr>
     <tr><th class="field-label">Risk Name:</th><td>{$item/RiskName/text()}</td></tr>
     <tr><th class="field-label">Risk Description:</th><td>{$item/RiskDescription/text()}</td></tr>
     <tr><th class="field-label">Risk Status:</th><td>{$sequence}</td></tr>
     <tr><th class="field-label">Probability:</th><td>{$item/RiskProbability/text()}</td></tr>
     <tr><th class="field-label">Impact:</th><td>{$item/RiskImpact/text()}</td></tr>
     <tr><th class="field-label">Score:</th><td>{$item/RiskScore/text()}</td></tr>
     <tr><th class="field-label">Status:</th><td>{$sequence2}</td></tr>
     <tr><th class="field-label">Owner:</th><td>{$item/RiskOwner/text()}</td></tr>
     <tr><th class="field-label">Risk Plan:</th><td>{$item/RiskPlan/text()}</td></tr>
      <tr><th class="field-label">Description:</th><td>{$item/RiskPlanDescription/text()}</td></tr>
   </tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)