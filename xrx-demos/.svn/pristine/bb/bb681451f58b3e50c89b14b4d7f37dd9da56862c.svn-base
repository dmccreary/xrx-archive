xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Project Admin Functions'

let $content := 
<div class="content">
    
      <a href="admin/create-system-collections.xq">Create Systems Collections</a> Create System Collections to store the index configuration file.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      
</div>

return 
    style:assemble-page($title, $content)
