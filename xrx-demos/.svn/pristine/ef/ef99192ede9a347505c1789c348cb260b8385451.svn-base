xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "modules/style.xqm";

let $title := 'Dan McCreary &amp; Associates'

let $content := 
<div class="content">
      <p>Welcome to the demonstration web site of {$title}.
      
      This site is currently under consutruction.
      
      Please contact <a href="mailto:dan@danmccreary.com">Dan McCreary</a> if you have any questions about this site.
      </p>
      
      <a href="{request:get-context-path()}/rest/db/dma/apps/index.xq">Demo applications</a>
      
</div>

return 
    style:assemble-page($title, $content)
