xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Comments Manager'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a template application.</p>
      
      
      <a href="views/list-items.xq">List</a> A listing of all comments <br/>
      
      <a href="edit/edit.xq?new=true">New</a> Create a new comment<br/>
      
      <a href="search/search-form.xq">Search</a> Search for a comment<br/>
            
      <a href="views/metrics.xq?new=true">Metrics</a> Comment Metrics<br/><br/>
      
      
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
