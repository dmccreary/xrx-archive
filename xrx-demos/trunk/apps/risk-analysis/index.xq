xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Risk Manager Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application can be used in conjunction with other Project Management apps to asses project risk and develop and store action plans for risk mitigation</p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of all Risks<br/>
      
      <a href="edit/edit.xq?new=true">New </a> Create a new Risk<br/>
      
      <a href="search/search-form.xq"> Search </a> Search for a Risk item<br/>
      
      <a href="views/metrics.xq">Metrics</a> Risk Metrics<br/><br/> 
      
      
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
