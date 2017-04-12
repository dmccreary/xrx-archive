xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')


let $name := request:get-parameter('name', '')
let $classifier := request:get-parameter('classifier', '')


let $title := concat('List Patterns with Classifier = ', $classifier)

let $count := count(collection($data-collection)/Pattern[Classifier=$classifier])

let $content := 
<div class="content">
      <p><b>Classifier=</b>{$classifier} <b>  Pattern Count: </b>{$count}</p>
      <table border="1">
         <thead>
            <th>Name</th>
            <th>Image</th>
            <th>Ref</th>
            <th>Description</th>
        </thead>
            <tbody>{
                for $pattern in collection($data-collection)/Pattern[Classifier=$classifier]
                   let $name := $pattern/PatternName/text()
                order by $name
                return
                <tr>
                    <td><a href="view-item.xq?name={$name}">{$name}</a></td>
                    <td><img src="../images/{$pattern/Image/text()}"></img></td>
                    <td><a href="{$pattern/Reference/text()}">Ref</a></td>
                    <td>{$pattern/Description/text()}</td>
                </tr>
              }</tbody>
      </table>
</div>

return 
    style:assemble-page($title, $content)


