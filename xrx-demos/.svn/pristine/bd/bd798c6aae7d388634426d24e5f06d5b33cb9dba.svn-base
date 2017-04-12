xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $id := request:get-parameter('id', '')
let $title :='View Requirement'
(: check for required parameters :)
return

if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $app-collection := $style:db-path-to-app
      let $data-collection := concat($app-collection, '/requirements')
      let $file := 'requirements.xml'
      let $file-path := concat($data-collection, '/', $file)
return
let $content :=
<div class="content">
   Path = {$file-path}<br/>
   {let $item := doc($file-path)/Requirements/Requirement[RequirementID = $id]
      return
         <table>
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
             <tr><th class="field-label">Requirement Name:</th><td>{$item/RequirementName/text()}</td></tr>
             <tr><th class="field-label">Project Description:</th><td>{$item/RequirementDescription/text()}</td></tr>
             </tbody>
          </table>
   }
  
 </div>
return style:assemble-page($title, $content)