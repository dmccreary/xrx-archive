xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Training Manager'

let $content := 
<div class="content">
      <p>Welcome to the {$title} application.
      
      This application manages a database of training classes and training labs.</p>
      
      
      <a href="views/list-classes.xq">List classes</a> A listing of classes.<br/>
      <a href="views/list-topic-categories.xq">List topics by category</a> A listing of training topics categories.<br/>
      
      <a href="views/list-topics.xq">List topics</a> A listing of training topics to be use in a class.<br/>
      <a href="views/list-labs.xq">List labs</a> A listing of labs.<br/>
      <a href="samples/index.xq">Sample Programs and Data</a> A listing of sample program and data files..<br/>
      
      <!--
      <a href="search/search-form.xq">Search</a> Search for an training class or lab<br/>
      
      
      <a href="edit/edit-class.xq?new=true">New Class</a> Create a New Class<br/>
      <a href="edit/edit-lab.xq?new=true">New Class</a> Create a New Lab<br/><br/>
      
      
      <h4>Administrative Tools</h4>
      <a href="admin/reindex.xq">Reindex</a> Reindex the data collection.<br/>
      <a href="admin/create-system-collections.xq">Create Systems Collections</a> Create System Collections to store the index configuration file.<br/>
      <a href="admin/install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area.<br/>
      -->
</div>

return 
    style:assemble-page($title, $content)
