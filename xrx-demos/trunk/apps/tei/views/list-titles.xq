xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $docs := $style:db-path-to-app-data
let $shakespeare := concat($docs, '/shakespeare')
let $title :=' '
let $content :=
<div class="span-16 content">
<table>
   <thead>
        <tr>
        <!-- <th>ID</th>  -->
        <th>Title</th>
        <th>Outline</th>
        <th>HTML</th>
        <th>XML</th>
        </tr>
    </thead>
    <tbody>{
        for $doc in $docs
        (: tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt :)
        let $id := string($doc/@xml:id)
        let $title := $doc/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()
        return
        <tr>
            <!-- <td>{$id}</td>  -->
            <td>{$title}</td>
            <td><a href="play-hierarchy.xq?id={$id}">Outline</a></td>
            <td><a href="view-item.xqid={$id}">HTML</a></td>
            <td><a href="../data/shakespeare">XML</a></td>
        </tr> 
    }</tbody>
</table>
</div>

return 
    style:assemble-page($title, $content)