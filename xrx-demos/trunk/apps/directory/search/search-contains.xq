xquery version "1.0";

(: Dan McCreary October 2010 :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $title := 'Employee Search'
let $q := request:get-parameter('q', '')
let $lcq := lower-case($q)

let $data-collection := $style:db-path-to-app-data

let $content :=
<div class="content">
   Search results for Query <b>{$q}</b><br/>
{for $hit in collection($data-collection)//person[contains(lower-case(./EmployeeName/text()), $lcq)]
  let $id := $hit/id/text()
  let $score := ft:score($hit)
  let $name := $hit/EmployeeName/text()
  order by $score descending
  return 
     <div>
     <br/>
        <a href="../views/view-item.xq?id={$id}">{$name}</a> 
     </div>
}

<br/>
 <div class="content">
 <div id="searchform">
        <form method="GET" action="search-contains.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>
     </div>
</div>

</div>

return style:assemble-page($title, $content)
