xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Harvard Forest Demo Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      </p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of items<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/>
      
      <a href="search/search-contains-form.xq">Search Contains</a> Search for an item<br/>
      
      <a href="views/metrics.xq">Metrics</a> Template Metrics<br/><br/> 
        
</div>

return 
    style:assemble-page($title, $content)
