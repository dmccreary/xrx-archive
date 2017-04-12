xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Lab Status'

let $content := 
<div class="content">
      <p>Welcome to {$title}.
      
      This application can be used by an instructor to monitor student progress in labs.</p>
      
      <a href="views/list-items.xq">List </a> A listing of the progress on each of the students.<br/>
      
      <a href="edit/edit.xq?new=true">New </a> Create a new student record.<br/>
            
       <a href="search/search-form.xq?new=true">Search </a> Search for a student record.<br/>
       
       <a href="views/metrics.xq">Metrics </a> Lab Status Metrics.
       <br/>
       <br/>
       
</div>

return 
    style:assemble-page($title, $content)
