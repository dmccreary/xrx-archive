xquery version "1.0";

(: Dan McCreary October 2010 :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Search Results'

let $q := request:get-parameter('q', '')
let $data-collection := $style:db-path-to-app-data

let $content :=
<div class="content">
  Search results for query <b>{$q}</b><br/>
<ol>
{for $hit in collection($data-collection)//xs:documentation[ft:query(., $q)]
  let $score := ft:score($hit)
  let $name := string($hit/../../@name)
  let $file := util:document-name($hit)
  order by $score descending
  return 
     <li> <a href="/rest/exist/{$data-collection}/{util:document-name($hit)}">{$file}</a> {' '} 
     <a href="../views/view-named-item.xq?file={$file}&amp;name={$name}">{$name}</a> {' '} 
     {$hit/text()} </li>

}
</ol>
</div>

return style:assemble-page($title, $content)
