xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title :='Project Manager'

let $content :=
<div class="content">
       <ol>
          <li>
             <a href="views/list-items.xq">List All Projects</a> All Projects
          </li>
          <li>
             <a href="views/list-users-items.xq?">Only My Projects </a> Only Projects 
             that I am a member of
          </li>
          <li>
             <a href="edit/edit.xq?new=true">New</a> Create a New Project
          </li>
          <li>
             <a href="search/search-form.xq">Search</a> Search Projects
          </li>
          <li>
             <a href="views/metrics.xq">Metrics</a> Counts of projects and code table entries
          </li>
         </ol>
         
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