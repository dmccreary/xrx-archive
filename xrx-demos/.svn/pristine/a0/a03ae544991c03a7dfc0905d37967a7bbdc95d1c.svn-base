xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $data-collection := '/db/org/northwestern/apps/tei/data/shakespeare'  (: $style:db-path-to-app-data :)
let $docs := collection($data-collection)/tei:TEI

let $title := 'List Plays'

let $content :=
<div class="span-22 content">
<p>Order by Title</p>
<table>
   <thead>
        <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Type</th>
        <th>Outline</th>
        <th>Reports</th>
        <th>HTML</th>
        <th>XML</th>
        </tr>
    </thead>
    <tbody>{
        for $doc in $docs
        (: tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt :)
        let $id := string($doc/@xml:id)
        let $title := $doc/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()
        let $id-suffix := substring-after($id, 'sha-')
        let $play-id := substring($id-suffix, 1, 3)
        let $file-name := concat($play-id, '.xml')
        let $type :=
          if ($doc//tei:castList)
             then ('Play')
             else ('Other')
        order by $title
        return
        <tr>
            <td>{$id}</td>
            <td>{$title}</td>
            <td>{$type}</td>
            <td><a href="play-hierarchy.xq?id={$id}">Outline</a></td>
            <td><a href="reports.xq?id={$id}">Reports</a></td>
            <td>
               {if ($type = 'Play')
                  then <a href="tei2html.xq?id={$id}">View Play</a>
                  else <a href="poem2html.xq?id={$id}">View Poem</a>
               }
            </td>
            <td><a href="/rest{$data-collection}/{$file-name}">XML</a></td>
        </tr> 
    }</tbody>
</table>
</div>

return 
    style:assemble-page($title, $content)