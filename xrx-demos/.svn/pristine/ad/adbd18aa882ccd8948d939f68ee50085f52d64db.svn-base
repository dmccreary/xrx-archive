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
{for $hit in collection($data-collection)//*[ft:query(., $q)]
  let $score := ft:score($hit)
  order by $score descending
  return 
     <li> <a href="{$data-collection}/{util:document-name($hit)}">{util:document-name($hit)}</a> {name($hit)} {string($hit/@name)}</li>

}
</ol>
</div>

return style:assemble-page($title, $content)
