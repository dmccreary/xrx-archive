xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Use Case Manager'

let $content := 
<div>
    <p>Welcome to the {style:app-name()}.</p>
       <p>Use Cases (a.k.a. User Stories) are short stories that describe how a user interacts with the system.  Use Cases are used
       in the requirements gathering process to clairify requirements.  For additional information on use cases/user stories, review the Wikipedia entry for "Use Case" at:
       <a href="http://en.wikipedia.org/wiki/Use_case">http://en.wikipedia.org/wiki/Use_case</a></p>
       
       <ol>
            <a href="views/list-items.xq">List</a> List of Use Cases<br/>
             <a href="edit/edit.xq?new=true">New</a> Create a New Use Case<br/>
             <a href="search/search-form.xq">Search</a> Search Use Cases<br/>
             <a href="views/metrics.xq">Metrics</a> Counts of Various Use Cases<br/>
       </ol>
       

</div>
     
return
    style:assemble-page($title, $content)