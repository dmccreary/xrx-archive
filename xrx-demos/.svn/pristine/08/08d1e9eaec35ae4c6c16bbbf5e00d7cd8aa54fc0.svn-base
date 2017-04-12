xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'List Risks'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-tables := doc(concat($app-collection, "/code-tables/risk-status-codes.xml"))//item


let $content :=
<div class="content">
       <table>
        <thead>
           <tr>
              <th>ID</th>
              <th>Project ID</th>
              <th>Risk Name</th>
              <th>Risk Score</th>
              <th>Risk Status</th>
              <th>Risk Owner</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/Risk
             let $id := $item/id/text()
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/Projectid/text()}</td>
                 <td>{$item/RiskName/text()}</td>
                 <td>{$item/RiskScore/text()}</td>
                 <td>{$code-tables[./value/text() = $item/RiskStatus/text()]/label/text()}</td>   
                 <td>{$item/RiskOwner/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody>
       </table>
  
</div>

return style:assemble-page($title, $content)