xquery version "1.0";

(: List Categories :)

import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

let $data-collection := $style:db-path-to-app-data
let $items := collection($data-collection)/item

let $content :=
    <table>
        <thead>
            <tr>
               <th>Category</th>
               <th>Count</th>
            </tr>
        </thead>
        <tbody>{
            for $category in distinct-values($items/category/text())
            return
                <tr>
                   <td>{$category}</td>
                   <td>{count($items[category=$category])}</td>
                </tr> 
        }</tbody>
    </table>

return 
    style:assemble-page($content)