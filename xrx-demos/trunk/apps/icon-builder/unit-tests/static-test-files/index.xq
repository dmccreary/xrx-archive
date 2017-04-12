xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../../modules/style.xqm";

let $title := 'Icon Builder Static SVG Tests'

let $app-collection := $style:db-path-to-app
let $collection := concat($app-collection, '/static-test-files')

let $content := 
    <div class="content">
       <table>
      {for $file at $count in xmldb:get-child-resources($collection)[. ne 'index.xq']
          return
          <tr>
             <td><a href="{$file}">{$file}</a></td>
             <td><a href="view-svg-as-xml.xq?file={$file}">{$file}</a></td>
          </tr>
      }
      </table>
    </div>                                           

return
    style:assemble-page($title, $content)