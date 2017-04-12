xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
 
let $title := 'List Dublin Core Sample Records'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Creator</th>
            <th>Subject</th>
            <th>Description</th>
            <!-- 
            <th>Publisher</th>
            <th>Contributor</th>
            <th>Date</th>
            <th>Type</th>
            <th>Format</th>
            <th>Identifier</th>
            <th>Source</th>
            <th>Language</th>
            <th>Relation</th>
            <th>Coverage</th>
            <th>Rights</th>
            -->
            <th>Edit</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/item
             let $id := $item/id/text()
             order by $id
          return
             <tr>
                 <td>{$id}</td>
                 <td><a href="view-item.xq?id={$id}">{$item/title/text()}</a></td>
                 <td>{$item/creator/text()}</td>
                 <td>{$item/subject/text()}</td>
                 <td>{$item/description/text()}</td>
                 <!--
                 <td>{$item/publisher/text()}</td>
                 <td>{$item/contributor/text()}</td>
                 <td>{$item/date/text()}</td>
                 <td>{$item/type/text()}</td>
                 <td>{$item/format/text()}</td>
                 <td>{$item/identifier/text()}</td>
                 <td>{$item/language/text()}</td>
                 <td>{$item/relation/text()}</td>
                 <td>{$item/coverage/text()}</td>
                 <td>{$item/rights/text()}</td>
                 -->
                 <td><a href="../edit/edit.xq?id={$id}">Edit</a></td>
             </tr> 
       }</tbody></table>
</div>

return style:assemble-page($title, $content)