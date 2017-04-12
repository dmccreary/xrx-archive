xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='List of Subscriptions'

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>User</th>
              <th>Subscription Name</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/Subscription
             let $id := $item/id/text()
          return
             <tr>
                 <td>{$id}</td>
                 <td>{$item/UserID/text()}</td>
                 <td>{$item/SubscriptionName/text()}</td>
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>

</div>
return style:assemble-page($title, $content)