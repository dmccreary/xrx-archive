xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'XML Schema to SVG'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application is a transforms XML Schemas into SVG drawings.</p>
      
      
      <a href="views/schema-to-svg.xq">Test</a> Sample.<br/>
      
     

      
      
</div>

return 
    style:assemble-page($title, $content)
