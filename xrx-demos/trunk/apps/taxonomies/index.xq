xquery version "1.0";

(: Dan McCreary Sept 2010 :)

import module namespace style = "http://surescripts.com/style" at "../../modules/style.xqm";

let $title := 'Surescripts Security Documents Taxonomy Manager'

let $content := 
<div class="content">
   <p>Welcome to the {$title}</p>
   
   <a href="views/list-items.xq">List Document Categories</a>
   <br/>
   <a href="views/select-options.xq">Select Options List</a>
    <br/>
   <a href="views/input-checkboxes.xq">Select Options Checkboxes</a>

 </div>
     
return style:assemble-page($title, $content)