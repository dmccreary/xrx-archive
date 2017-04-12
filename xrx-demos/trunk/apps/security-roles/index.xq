xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../modules/style.xqm';

let $title := 'Security Role Manager'

let $content := 
    <div>
         <p>Welcome to the Role manager.  This application manages XML files that describes
             authorization roles for managing what users have access to what resources.  Note
             that a role may be used in one or more named server configurations.
          </p>
          
        <a href="views/list-items.xq">List</a> List of Roles <br/>
        <a href="edit/edit.xq?new=true">New</a> Create a New Role <br/>
        <a href="search/search-form.xq">Search</a> Search for a Role<br/>
         <a href="views/metrics.xq">Metrics</a> Security Role Metrics
        
     <br/><br/>

     </div>
     
return
    style:assemble-page($title, $content)
