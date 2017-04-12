xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Timeline Events Manager'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is used to manage individual events that can be constructed into a timeline.</p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of all events<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new event<br/>
      
      <a href="search/search-contains-form.xq"> Search</a> Search for an event<br/>
      
      <a href="views/metrics.xq">Metrics</a> Event Metrics<br/><br/> 
      
      
   {if (util2:is-dba())
        then
          <div class="admin-only">
             <a href="admin/index.xq">Admin</a> Application Administrator Functions
          </div>
        else ()
      }
   
</div>

return 
    style:assemble-page($title, $content)
