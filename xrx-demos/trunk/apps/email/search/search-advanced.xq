xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Email Advanced Search Results'
let $data-collection := $style:db-path-to-app-data
let $parameters := request:get-parameter-names()

(: put the search results into memory using the eXist any keyword ampersand equals comparison :)
let $count := count($parameters)

let $content :=
<div class="content">
        <h3>Search Parameters</h3>
     <ol>{
          for $parameter in $parameters
          order by $parameter
          return
            <li>
               {$parameter} = {request:get-parameter($parameter, '')}
            </li>
      }</ol>
      <a href="search-custom.xq">New Search</a>
</div>

return style:assemble-page($title, $content)
