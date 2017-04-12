xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Twitter Feed Widget Testing Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.</p>
      
      <a href="http://twitter.com/about/resources/widgets">Twitter Widgets</a><br/>
      
      <a href="http://twitter.com/about/resources/widgets/widget_search">Twitter Search Widgets</a><br/>
      
      <a href="unit-tests/index.xq">List all unit tests</a><br/>
      
      <!--
      <a href="unit-tests/twitter-feed-original.html">Test of Twitter Widget</a> Test of Twitter Feed Widget in JavaScript<br/>
      
      
      <a href="views/list-items.xq">List items</a> A listing of items<br/>
      
      <a href="search/search-form.xq">Search</a> Search for an item<br/>
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/><br/>
      
      <h4>Administrative Tools</h4>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      <a href="admin/create-system-collections.xq">Create Systems Collections</a> Create System Collections to store the index configuration file.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      -->
</div>

return 
    style:assemble-page($title, $content)
