xquery version "1.0";

(: Dan McCreary October 2010 :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'XML Schema Contains Exact'
let $q := request:get-parameter('q', '')

let $data-collection := $style:db-path-to-app-data

let $content :=
<div class="content">
   Search results for Query <b>{$q}</b><br/>
{for $hit in collection('/db/surescripts/apps/schemas/data')//(xs:element|xs:complexType|xs:documentation)[contains(./@name, $q)]
  let $score := ft:score($hit)
  let $name := string($hit/@name)
  order by $score descending
  return 
     <div>
        <a href="/exist/rest{$data-collection}/{util:document-name($hit)}">{util:document-name($hit)}</a>  {' '} type={name($hit)} {' '} {$name}
     </div>

}
</div>

return style:assemble-page($title, $content)
