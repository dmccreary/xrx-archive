xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: short-names.xq -
   Get a list of all of the ShortNames from the requirements database.
   
   Author: Dan McCreary :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $requriements := collection($data-collection)/Requirement

let $sorted-requirments :=
   for $requirement in $requriements
   order by $requirement/RequirementShortName/text()
   return $requirement
   
return
<code-table>
   <code-table-name>RequirementNameCode</code-table-name>
   <items>
       <item>
          <label>Select an item</label>
          <value></value>
       </item>
   { for $requirement in $sorted-requirments
       return
       <item>
          <label>{$requirement/RequirementShortName/text()}</label>
          <value>{$requirement/id/text()}</value>
       </item>
   }
    </items>
</code-table>