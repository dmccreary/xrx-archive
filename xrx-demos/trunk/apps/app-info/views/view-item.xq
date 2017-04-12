xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace xrx="http://code.google.com/p/xrx";

let $id := request:get-parameter('id', '')
let $title := concat('View AppInfo File ', $id)

(: check for required parameters :)
return
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else

let $site-root-collection := $style:db-path-to-site
let $file := concat($site-root-collection, '/apps/', $id, '/app-info.xml')
let $item := doc($file)/xrx:app-info[xrx:app-id/text() = $id]

let $content :=
<div class="content">
 <table class="span-12">
  <thead>
       <tr>
          <th class="span-6">Field</th>
          <th class="span-14 last">Value</th>
       </tr>
  </thead>
  <tbody>
     <tr><th class="field-label">App ID:</th><td>{$item/xrx:app-id/text()}</td></tr>
     <tr><th class="field-label">App Name:</th><td>{$item/xrx:app-name/text()}</td></tr>
     <tr><th class="field-label">App Description:</th><td>{$item/xrx:app-description-text/text()}</td></tr>
     <tr><th class="field-label">Creator:</th><td>{$item/xrx:app-creator-text/text()}</td></tr>
     <tr><th class="field-label">License Type:</th><td>{$item/xrx:app-license-type-code/text()}</td></tr>
     <tr><th class="field-label">License URL:</th><td>{$item/xrx:app-license-uri/text()}</td></tr>
     <tr><th class="field-label">Breadcrumb Label:</th><td>{$item/xrx:breadcrumb-label/text()}</td></tr>
     <tr><th class="field-label">Data Collection:</th><td>{$item/xrx:data-collection/text()}</td></tr>
     <tr><th class="field-label">Icon Path:</th><td>{$item/xrx:app-icon-path/text()}</td></tr>
     <tr><th class="field-label">Main Menu Order:</th><td>{$item/xrx:main-menu-order/text()}</td></tr>
     <tr><th class="field-label">Include Global Search:</th><td>{$item/xrx:include-in-search-indicator/text()}</td></tr>
     <tr><th class="field-label">Path To Root Node:</th><td>{$item/xrx:doc-root-path/text()}</td></tr>
     <tr><th class="field-label">Path To ID:</th><td>{$item/xrx:doc-id-path/text()}</td></tr>
     <tr><th class="field-label">Path To Tite:</th><td>{$item/xrx:doc-title-path/text()}</td></tr>
     <tr><th class="field-label">List Items URI:</th><td>{$item/xrx:list-items-uri/text()}</td></tr>
     <tr><th class="field-label">Doc Viewer URI:</th><td>{$item/xrx:doc-viewer-uri/text()}</td></tr>
     <tr><th class="field-label">Help URL:</th><td>{$item/xrx:app-notes-text/text()}</td></tr>
     <tr><th class="field-label">Search Order Weight:</th><td>{$item/xrx:search-order-weight/text()}</td></tr>
     <tr><th class="field-label">Include in New:</th><td>{$item/xrx:include-in-new-indicator/text()}</td></tr>
     <tr><th class="field-label">New Item URI:</th><td>{$item/xrx:app-new-uri/text()}</td></tr>
     <tr><th class="field-label">Notes:</th><td>{$item/xrx:app-notes-text/text()}</td></tr>
   </tbody>
  </table>
   
  <h3>Role Permissions</h3>
  <table class="span-8">
     <thead>
        <tr>
           <th class="span-4">Role</th>
           <th class="span-4 last">Action</th>
        </tr>
     </thead>
     <tbody>{for $permission in $item//xrx:permission
        return
           <tr>
              <td>{$permission/xrx:role/text()}</td>
              <td>{$permission/xrx:action/text()}</td>
           </tr>
     }</tbody>
  </table>
  {style:revision-status-table($item)}
  {style:edit-controls($id)}
</div>

return style:assemble-page($title, $content)