xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
let $title := 'Subscription Manager' 

let $content :=
<div class="content">
       <ol>
          <li>
             <a href="views/list-items.xq">List</a> List of Subscriptions
          </li>
          <li>
             <a href="edit/edit.xq?new=true">New</a> Create Subscriptions
          </li>
          <li>
             <a href="search/search-form.xq">Search</a> Search Subscriptions 
          </li>
          <li>
             <a href="views/metrics.xq">Metrics</a> Counts of various Enterprise Service Bus (ESB) Subscriptions
          </li>
       </ol>
</div>

return
    style:assemble-page($title, $content)