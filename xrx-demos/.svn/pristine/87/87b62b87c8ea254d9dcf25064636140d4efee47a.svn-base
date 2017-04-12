xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Requirements Hierarchy Report by Level'

let $show-arch-sig-string := request:get-parameter('show-as', 'false')
let $level := request:get-parameter('show-as', 'level')
let $show-arch-sig := xs:boolean(if ($show-arch-sig-string = 'true') then true() else false())

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $level-1-requirements := collection($data-collection)/Requirement[RequirementParentID = '1']
let $requirments-count := count($level-1-requirements)

return
(: check for required parameters :)
if (count($requirments-count) < 1)
    then
        <error>
            <message>No requirements found that have a RequirementParentID of 1</message>
        </error>
    else
   

let $content :=
<div class="content">
   Total Count={$requirments-count}<br/>
   <table>
      <thead>
         <tr>
            <th>Name</th>
            <th>Priority</th>
            <th>Hierarchy</th>
            <th>Description</th>
         </tr>
      </thead>
    {for $requirement in $level-1-requirements
        let $id := $requirement/id/text()
        let $name := $requirement/RequirementShortName/text()
        order by $requirement/RequirementPriorityCode
        return
        <tr>
           <td>
              <a href="view-item.xq?id={$id}" title="{$id}">{$name}</a>
           </td>
           <td>{$requirement/RequirementPriorityCode/text()}</td>
           <td>
              <a href="hierarchy.xq?id={$id}">Hierarchy</a>
           </td>
           <td>{$requirement/RequirementDescriptionText/text()}</td>
        </tr>
    }
    </table>
   <a href="../edit/edit.xq?new=true">New Requirement</a>
</div>


return style:assemble-page($title, $content)