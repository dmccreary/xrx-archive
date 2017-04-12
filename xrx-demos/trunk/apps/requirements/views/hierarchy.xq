xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: recursive function to list all sub-requirements of a requirement :)
declare function local:sub-req($req-id as xs:string, $depth as xs:integer, $show-as as xs:boolean) as node()* {
   let $app-collection := $style:db-path-to-app 
   let $data-collection := concat($app-collection, '/data')
   let $current-req := collection($data-collection)/Requirement[id=$req-id]
   
   return
   if ($current-req[RequirementCompletionStatusCode != 'removed'])
   then
    <ul>
       <li>
          <a href="view-item.xq?id={$req-id}">{$current-req/RequirementShortName/text()}</a> 
          ({$req-id})
          {if ($show-as and $current-req[RequirementClassifierCode='architecturally-significant'])
             then <img src="../images/arch-sig.png" alt="Architecturally Significant" height="22px" title="Architecturally Significant"/>
             else ()
          }
          - 
          {$current-req/RequirementDescriptionText} ${$current-req/RequirementCostEstimateAmount}
       </li>
       { (: Check for sub-requirements :)
       if (exists(collection($data-collection)/Requirement[RequirementParentID=$req-id]) and $depth < 10)
         then (
            (: Find all requirements that are sub-requirements of this requirement. :)
            for $sub in collection($data-collection)/Requirement[RequirementParentID=$req-id]
                order by lower-case($sub/RequirementShortName/text())
                return
                local:sub-req(xs:string($sub/id/text()), $depth + 1, $show-as)
             )
         else ()
         }
    </ul>
    else ()
};

let $title := 'Requirements Hierarchy Report'

(: if no starting point ID is specificed, then just start at ID = 1 :)
let $id := request:get-parameter('id', '1')
let $show-arch-sig-string := request:get-parameter('show-as', 'false')
let $show-arch-sig := xs:boolean(if ($show-arch-sig-string = 'true') then true() else false())

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: list-requirements-hierarchy.xq
   recursive decent of requirments
   Author: Dan McCreary
   Date: 10-25-2007
   Modified: 2-20-2009
:)

(: make sure we have one and only one root element (where the parent ID is 0 :)
let $root := collection($data-collection)/Requirement[id/text()=$id]
let $root-count := count($root)

return
(: check for required parameters :)
if ($root-count ne 1)
    then
        <error>
            <message>Must have exactly one root node with an ID of {$id}.  Found {$root-count}</message>
        </error>
    else
   
let $total-count := count(collection($data-collection)/Requirement)

let $content :=
<div class="content">
        Total Count={$total-count}<br/>

        {local:sub-req($id, 1, false() )}
        
        <div class="key">
        </div>
        
        <img src="../images/arch-sig.png" alt="Architecturally Significant" height="25px" title="Architecturally Significant"/> = Architecturally Significant Requirement
       
        <a href="../edit/edit.xq?new=true">New Requirement</a>
</div>


return style:assemble-page($title, $content)