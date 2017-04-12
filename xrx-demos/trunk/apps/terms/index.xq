xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Glossary of Terms Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application manages the Company Glossary of Terms and allows viewing of Reference Terms Glossaries</p>
      
      
      
      <a href="views/list-items.xq">List items</a> A listing of items<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/>
      
      <a href="search/search-form.xq">Search</a> Search for an item<br/>
      
     <a href="views/metrics.xq">Metrics</a> Term Metrics<br/>
 
      <br/>
      <h4>Unit Tests</h4>
      <a href="unit-tests/ui-terms.html">UI Terms CSS Test</a>
      <br/>
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
