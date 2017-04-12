xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'AnyChart Unit Tests'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.</p>
      {for $file in xmldb:get-child-resources( concat($style:db-path-to-app, '/unit-tests') )
         order by $file
         return
         if (not(($file = 'index.xq')) and ends-with($file, '.xq'))
           then <div><a href="{$file}">{$file}</a></div>
           else ()
      }
</div>

return 
    style:assemble-page($title, $content)
