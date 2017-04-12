xquery version "1.0";

(: Dan McCreary Sept 2010 :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Employee Directory'

let $content := 
<div class="content">
   <p>Welcome to the {$title}.  This Application is used to manage company directory operations.</p>
   
    <ol>
              <a href="views/list-items.xq">List</a> List all employees in the company directory
              <br/>
              <a href="edit/edit.xq?new=true">New</a> Create a new employee record
              <br/>
              <a href="search/search-form.xq">Search</a> Search employees in the company directory
              <br/>
              <a href="views/metrics.xq">Metrics</a> Employee counts by location (state) and role
        
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