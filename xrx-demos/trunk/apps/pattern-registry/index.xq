xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Enterprise Integration Pattern Registry'

let $content := 
<div class="content">
   <p>The pattern registry holds a set of integration patterns and allows designers to note
      which patterns are used in various designs of XRX applications.  This helps
      future XRX designers understand what design decisions were made and why they were made.</p>

          <a href="views/list-items.xq">List</a> List of Patterns in the Registry<br/>

          <!--

             <a href="edit/edit.xq?new=true">New</a> Create New Pattern<br/>

             <a href="search/search-form-html.xq">Search</a> Search Patterns<br/>

             <a href="views/metrics.xq">Metrics</a> Counts of various Patterns<br/>

      <h4>Administrative Tools</h4>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      <a href="admin/create-system-collections.xq">Create Systems Collections</a> Create System Collections to store the index configuration file.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      -->
</div>

return 
    style:assemble-page($title, $content)