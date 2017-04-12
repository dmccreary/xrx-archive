xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace req="http://www.mnhs.org/requirements" at "../modules/requirements.xqm";
declare namespace xsl = "http://www.w3.org/1999/XSL/Transform";

let $title := 'Cost Report'

(: Author: Dan McCreary :)

let $app-collection := '/db/dma/apps/requirements' (: $style:db-path-to-app :)
let $data-collection := concat($app-collection, '/data')
let $requirements := collection($data-collection)/Requirement

let $leaf-requirements :=
    for $requirement in $requirements[req:is-leaf(./id/text())]
      return
        $requirement
  
let $total-count := count($requirements)
let $leaf-requirements-count := count($leaf-requirements)

let $content :=
<div class="content">

  <style type="text/css"><![CDATA[
     td {text-align: right}
     td.center {text-align: center}
     td.left {text-align: left}
  ]]></style>

  <p>data collection = {$data-collection}</p>
  Total Requirement Count={$total-count}<br/>
  Leaf Requirement Count={$leaf-requirements-count}<br/>
 
 
    <table>
        <thead>
        <tr>

              <th></th>
              <th></th>
              <th></th>
              <th></th>
              <th colspan="3" style="text-align:center;">Cost Estimates</th>
          </tr>
          <tr>

              <th>Name</th>
              <th>Status</th>
              <th>% Done</th>
              <th>Certainty</th>
              <th>Low</th>
              <th>Medium</th>
              <th>High</th>
          </tr>
     </thead>
     <tbody>{
     for $req at $count in $leaf-requirements
        let $id := $req/id/text()
        let $cost-low := number($req/RequirementCostEstimateAmount/text()) *.5
        let $cost-high := number($req/RequirementCostEstimateAmount/text()) * 2
        let $requirement-name := $req/RequirementShortName/text()
      
     return
    
   <tr>
     {if ($count mod 2)
        then attribute class {'odd'}
        else attribute class {'even'}
      }
      <td class="left"><a href="view-item.xq?id={$id}">{$requirement-name} ({$id})</a></td>
      <td class="center">{$req/RequirementCompletionStatusCode/text()}</td>
      <td>{number($req/RequirementCompletionPercent/text())}%</td>
      <td>{$req/RequirementCostCertaintyCode/text()}</td>
      <td>{ xsl:format-number($cost-low, '$#,###') }</td>
      <td>{ xsl:format-number($req/RequirementCostEstimateAmount/text(), '$#,###') }</td>
      <td>{ xsl:format-number($cost-high, '$#,###') }</td>
    </tr>
       }</tbody>
       <thead>
          <tr><th colspan="5"></th></tr>
        </thead>
         <tr>
              <td colspan="3">Total Cost:</td> <td text-align="right">{
              xsl:format-number(
                 sum( $leaf-requirements/RequirementCostEstimateAmount/text() ), '$#,###'
                 )
             }</td>
            
            
          </tr>
     </table>
    

</div>

return style:assemble-page($title, $content)
