xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := "View Item"

let $id := request:get-parameter('id', '')

(: check for required parameters :)
return
if (not($id)) then 
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>
else

let $data-collection := $style:db-path-to-app-data
let $item := collection($data-collection)/*[id = $id][1]
let $content :=
<div class="content span-24">
    <p>View of file: {$data-collection}</p>
    <table>
        <tbody>
            <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>
            <tr><th class="field-label">File Name:</th><td>{util:document-name($item)}</td></tr>
            <tr><th class="field-label">Author:</th><td>{$item/author/text()}</td></tr>
            <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
            <tr><th class="field-label">Category:</th><td>{$item/category/text()}</td></tr>
            <tr><th class="field-label">Status:</th><td>{$item/status/text()}</td></tr>
            <tr><th class="field-label">Tag:</th><td>{$item/tag/text()}</td></tr>
        </tbody>
    </table>
    
    <h3>Queries</h3>

        <div class="queries">
        {for $query in $item/query
        return
            <div class="query">
               <b>{$query/description/text()}</b><br/>
               <pre>{$query/code/text()}</pre>
            </div>
        }
        </div>


</div>
        
return style:assemble-page($title, $content)