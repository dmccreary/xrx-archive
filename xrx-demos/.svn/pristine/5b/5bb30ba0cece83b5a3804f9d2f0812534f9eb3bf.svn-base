xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Range Control Registry Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is allows you to manage a set of range controls that may be applied to a gauge.</p>
      
      
      <a href="views/list-items.xq">List items</a> A listing of ranges <br/>
      
      <a href="search/search-form.xq">Search</a> Search for an ranges<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new range<br/><br/>
      
      <h4>Administrative Tools</h4>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      
</div>

return 
    style:assemble-page($title, $content)
