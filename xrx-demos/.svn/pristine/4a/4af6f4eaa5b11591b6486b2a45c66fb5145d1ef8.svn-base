xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Kert Unit Test Runner'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.<br/>
      
      This application is designed to run unit tests.</p>
      
      <a href="views/list-items.xq">List tests</a> A listing of tests<br/>
      
      <a href="edit/edit.xq?new=true">New test</a> Create a new test<br/>
      
      <a href="search/search-contains-form.xq">Search Contains</a> Search for a test using non-indexed search.<br/>
      
      <a href="search/search-fulltext-form.xq">Search Fulltext</a> Search for a test using Lucene fulltext search.<br/> 
      
      <a href="views/metrics.xq">Metrics</a>Counts of the number of unit tests in the database.<br/><br/> 
      
      
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
