xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'XRX Template Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a template application.</p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of items<br/>
      
      <a href="search/search-form.xq">Search</a> Search for an item<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/>
      
</div>

return 
    style:assemble-page($title, $content)
