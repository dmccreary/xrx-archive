xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'View Dublin Core Sample Data'

let $id := request:get-parameter('id', '')

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


let $content :=
<div class="content">
       <h1>View Item</h1>
   {let $item := collection($data-collection)/item[id = $id]
      return
         <table>
            <tbody>
             <tr><th class="field-label">ID:</th><td>{$item/id/text()}</td></tr>         
             <tr><th class="field-label">Title:</th><td>{$item/title/text()}</td></tr>
             <tr><th class="field-label">Creator:</th><td>{$item/creator/text()}</td></tr>
             <tr><th class="field-label">Subject:</th><td>{$item/subject/text()}</td></tr>
             <tr><th class="field-label">Description:</th><td>{$item/description/text()}</td></tr>
             <tr><th class="field-label">Publisher:</th><td>{$item/publisher/text()}</td></tr>
             
             <tr><th class="field-label">Contributor:</th><td>{$item/contributor/text()}</td></tr>
             <tr><th class="field-label">Date:</th><td>{$item/date/text()}</td></tr>
             <tr><th class="field-label">Type:</th><td>{$item/type/text()}</td></tr>
             <tr><th class="field-label">Format:</th><td>{$item/format/text()}</td></tr>
             <tr><th class="field-label">Identifier:</th><td>{$item/identifier/text()}</td></tr>
             
             <tr><th class="field-label">Source:</th><td>{$item/source/text()}</td></tr>
             <tr><th class="field-label">Language:</th><td>{$item/language/text()}</td></tr>
             <tr><th class="field-label">Relation:</th><td>{$item/relation/text()}</td></tr>
             <tr><th class="field-label">Coverage:</th><td>{$item/coverage/text()}</td></tr>
             <tr><th class="field-label">Rights:</th><td>{$item/rights/text()}</td></tr>
             </tbody>
          </table>
   }
   
   <a href="view-html-4.xq?id={$id}">View Using HTML 4 Metadata</a><br/>
   
    <a href="view-rdf.xq?id={$id}">View Using RDF Metadata</a><br/>
   
   <a href="../edit/edit.xq?id={$id}">Edit Item</a>
             <a href="../edit/delete-confirm.xq?id={$id}">Delete Item</a>
</div>

return style:assemble-page($title, $content)