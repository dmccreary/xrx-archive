xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'List of Patterns'

let $data-collection := $style:db-path-to-app-data

let $patterns := collection($data-collection)//Pattern

let $content := 
<div class="content">
      <p><b>Pattern Count: </b>{count($patterns)}</p>
      <table border="1">
         <thead>
            <th>Pattern Name</th>
            <th>Classifier</th>
            <th>Image</th>
            <th>Ref</th>
            <th>Description</th>
        </thead>
            <tbody>{
                for $pattern in collection($data-collection)/Pattern
                   let $id := $pattern/id/text()
                   let $name := $pattern/PatternName/text()
                order by $name
                return
                <tr>
                    <td><a href="view-item.xq?id={$id}">{$name}</a></td>
                    <td><a href="list-patterns-with-classifier.xq?classifier={$pattern/Classifier/text()}">{$pattern/Classifier/text()}</a></td>
                    <td><img src="../images/{$pattern/Image/text()}"></img></td>
                    <td><a href="{$pattern/Reference/text()}">Ref</a></td>
                    <td>{$pattern/Description/text()}</td>
                </tr>
              }</tbody>
      </table>
</div>

return 
    style:assemble-page($title, $content)

