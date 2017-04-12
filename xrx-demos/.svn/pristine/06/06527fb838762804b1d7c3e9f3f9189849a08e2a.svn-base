xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'SVG Demos'

let $content := 
<div class="content">
      <p>Welcome to the {$title} application.  These applications run on most browsers, even Intenet Explorer.</p>
      
      
      <a href="views/list-items.xq">List demos</a> A listing of SVG demos<br/>
      
      <a href="search/search-form.xq">Search</a> Search for an item<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/><br/>
      
      <h4>Administrative Tools</h4>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      <a href="admin/create-system-collections.xq">Create Systems Collections</a> Create System Collections to store the index configuration file.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      
</div>

return 
    style:assemble-page($title, $content)
