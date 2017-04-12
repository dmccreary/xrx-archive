xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Office Open XML Unit Tests'

let $unit-test-collection := concat($style:db-path-to-app, '/unit-tests')

let $content := 
<div class="content">
      <p>Welcome to the {$title}.</p>
      <ol>{
      for $child in xmldb:get-child-resources($unit-test-collection)
         order by $child
         return
            <li>
               <a href="{$child}">{$child}</a>
            </li>
      }</ol>
      
      
      
</div>

return 
    style:assemble-page($title, $content)
