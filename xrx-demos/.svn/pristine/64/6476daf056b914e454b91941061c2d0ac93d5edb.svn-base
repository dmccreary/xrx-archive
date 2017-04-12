xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'XRX Book Demo Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application can be used as a basis for building other standard applications</p>
      
      
      <a href="views/list-items.xq">List Books </a> A listing of all books in the collection<br/>
      
      <a href="edit/edit.xq?new=true">New Book </a> Create a new book<br/>
      
      <a href="search/search-contains-form.xq">Search Contains </a> Search for an book using sequential search.<br/>
      
      <a href="search/search-form.xq">Search Fulltext </a> Search for an book using Lucene fulltext search.<br/> 
      
      <a href="views/metrics.xq">Metrics </a>Counts of books by type.<br/><br/> 
      
      
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
