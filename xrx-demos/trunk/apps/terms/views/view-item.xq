xquery version "1.0";

(: View Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $id := request:get-parameter('id', '')
let $title := 'View Term' 

(: check for required parameters :)
return
if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else

let $data-collection := $style:db-path-to-app-data
let $item := collection($data-collection)//term[id = $id]

(: put this in to enable RBAC {style:edit-controls($id)} :)

let $content := 
<div class="content">
    <table class="span-20 last">
        <thead>
           <tr>
              <th class="span-4">Field</th>
              <th class="span-16 last">Value</th>
           </tr>
        </thead>
        <tbody>
            <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
            <tr><th class="field-label">Name:</th><td>{$item/term-name/text()}</td></tr>
            <tr><th class="field-label">Abbreviation:</th><td>{$item/abbreviation/text()}</td></tr>
            <tr><th class="field-label">Definition:</th><td>{$item/definition/text()}</td></tr>
            <tr><th class="field-label">Broader Term ID:</th><td>{$item/broader-term-id/text()}</td></tr>
            <tr><th class="field-label">See Also Term ID:</th><td>{$item/see-also-term-id/text()}</td></tr>
            <tr><th class="field-label">Wickipedia Name:</th><td>{$item/wikipedia-name/text()}</td></tr>
            <tr><th class="field-label">Approval Status:</th><td>{$item/approval-status-code/text()}</td></tr>
            <tr><th class="field-label">Classifier Code:</th><td>{$item/classifier-cod/text()}</td></tr>
            <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
            <tr><th class="field-label">Author Code:</th><td>{$item/author-code/text()}</td></tr>
        </tbody>
    </table>
       {style:revision-status-table($item)}
        
       {style:edit-controls($id)}
</div>
        
return style:assemble-page($title, $content)