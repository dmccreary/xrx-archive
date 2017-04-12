xquery version "1.0";
import module namespace style = "http://surescripts.com/style" at "../../../modules/style.xqm";

(: list all the data in a given taxonomy file :)

let $file := request:get-parameter('file', 'security-documents.xml')

let $title := "List Document Categories"

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
return

let $content :=
<div class="content">

      <ul>
       {
          for $top-level-category in doc($doc-path)/taxonomy/category
             let $name := $top-level-category/category-name/text()
          return
             <li>{$name}
                <ol>
                {for $sub-category in $top-level-category/category
                   let $cat-id := $sub-category/category-id/text()
                return
                   <li><a href="../../docs/search/echo-url-parameters.xq?category={$cat-id}">{$sub-category/category-name/text()}</a></li>
                }
                </ol>
             </li>
       }
  </ul>
</div>

return style:assemble-page($title, $content)