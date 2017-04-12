xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Administrator Functions for User Manager'

let $content :=
<div class="content">
      
     <a href="reindex.xq">Reindex</a> Reindex the data collection
     <br/>
   
     <a href="create-systems-collection.xq?new=true">Create Systems Collection</a> Create New User
     <br/>
     
     <a href="install-collection-config.xq">Install Collection Config</a> Copy the configuration file to the system area 
     <br/>
        
</div>

return 
    style:assemble-page($title, $content)