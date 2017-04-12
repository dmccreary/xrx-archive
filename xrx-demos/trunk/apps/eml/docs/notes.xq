xquery version "1.0";

(: Notes Page :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'EML Notes'

let $content := 
<div class="content">
      <p>Welcome to the {$title} page.</p>
      
      <a href="http://harvardforest.fas.harvard.edu/data-archive">Harvard Forest Data Archive</a><br/>
      
</div>

return 
    style:assemble-page($title, $content)
