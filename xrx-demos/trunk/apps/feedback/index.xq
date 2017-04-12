xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Feedback Manager'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a template application.</p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of feedback items<br/>
      
      <a href="search/search-form.xq">Search</a> Search for a feedback item<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new feedback item<br/> 
      
        <a href="views/metrics.xq?new=true">Metrics</a> Metrics for feedback items
        <br/><br/> 
      
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
