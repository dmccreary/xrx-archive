xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'XRX Timeline Template Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a template application.</p>
      
      
      <a href="views/events-at-time.xq?date=2011-04-01">Events on April 1st</a> <br/>
      
      <a href="views/simile-timeline-viewer.xq?timeline-id=2">Simile Timeline Viewer</a> <br/>
      <a href="views/timeline-to-data.xq?timeline-id=2">Timeline data</a> <br/>
      
         
</div>

return 
    style:assemble-page($title, $content)
