xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace xf-util = "http://danmccreary.com/xforms-utils" at '../../../modules/xforms-utils.xqm';
declare namespace xhtml ="http://www.w3.org/1999/xhtml";

let $title := 'List XForms Demos'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $forms := collection($data-collection)/xhtml:html
let $chapter-codes := xf-util:find-code-table($style:app-id, 'chapter-title-code')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>Chapter</th>
              <th>Example</th>
              <th>Description</th>
              <th>View in XSLTForms</th>
              <th>View in BetterFORM</th>
              <th>XML</th>
           </tr>
        </thead>
        <tbody>{
          for $item in $forms
             let $id := concat(util:collection-name($item), '/', util:document-name($item))
             let $rel-path := substring-after($id, '/db/dma/apps/xforms-examples/data/')
             let $chapter := substring-before($rel-path, '/')
             let $example-collection := substring-before(substring-after($rel-path, '/'), '/')
             let $file-path := concat($chapter, '/', $example-collection, '/', util:document-name($item))
             order by $id
          return
             <tr>
                 <td>{xf-util:value-to-label($chapter-codes, $chapter)}</td>
                 <td>{$example-collection}</td>
                 <td></td>
                 <td><a href="render-xsltforms.xq?id={$file-path}">XSLTForms</a></td>
                 <td><a href="">BetterFORM</a></td>
                 <td><a href="../views/get-instance.xq?id={$file-path}">XML</a></td>
             </tr> 
       }</tbody></table>
  
</div>

return style:assemble-page($title, $content)