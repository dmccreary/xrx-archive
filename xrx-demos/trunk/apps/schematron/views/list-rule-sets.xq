xquery version "1.0";
import module namespace style = "http://nuemeta.com/style" at "../../../modules/style.xqm";

let $title := 'List Schematron Rules Files'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')
let $db-path := $style:web-path-to-app
let $content :=
<div class="content">
        <p>Sort Latest Modified</p>
        <table>
        <thead>
           <tr>
              <th>File Name</th>
              <th>Created</th>
              <th>Modified</th>
              <th>Size</th>
              <th>Edit</th>
              <th>Compile</th>
              <th>XML</th>
           </tr>
        </thead>
        <tbody>{
         for $child in xmldb:get-child-resources($data-collection)
         let $modified := xmldb:last-modified($data-collection, $child)
         order by $child
         return
        <tr>
            <td>{$child}</td>
            <td>{xmldb:created($data-collection, $child)}</td>
            <td>{$modified}</td>
            <td  align="center">{xmldb:size($data-collection, $child) div 1024}</td>
            <td  align="center"><a href="../edit/edit.xq?id={$child}">Edit</a></td>
            
            <td><a href="{concat(request:get-context-path(), '/rest', $db-path, '/rule-sets/', $child)}">XML</a></td>
        </tr>
        }</tbody>
      </table>
</div>

return
    style:assemble-page($title, $content)
