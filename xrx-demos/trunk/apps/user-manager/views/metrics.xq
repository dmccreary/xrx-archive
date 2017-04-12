xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='User Metrics'
let $roles := collection($data-collection)//role/text()
let $distinct-values := distinct-values($roles)
let $count := count($distinct-values)

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  <table border="1">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td align="right">Number of Users: </td>
           <td>{count(collection($data-collection)/user)}</td>
        </tr>
        <tr>
           <td align="right">Number of roles: </td>
           <td>{$count}</td>
        </tr>
    </tbody>
  </table>
  
    <div class="edit-controls">
       <a href="../index.xq">Main Menu</a> 
    </div>
  </div>

return style:assemble-page($title, $content)