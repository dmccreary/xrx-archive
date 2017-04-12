xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace glossary = "http://danmccreary.com/glossary" at "../modules/glossary-module.xqm";

let $title := 'List Glossary of Terms'

let $data-collection := $style:db-path-to-app-data
let $paginate := request:get-parameter('paginate', 'yes')
let $start := xs:integer(request:get-parameter('start', 0))
let $perpage := xs:integer(request:get-parameter('perpage', 100))

(: style:paginated-list-links() constructs links to each page of results; 
 : it handles the $start parameter, so we need to pass any other parameters 
 : to it via a $url-params :)
let $url-params := 
    string-join(
        (
        if ($paginate ne 'yes') then concat('paginate=', $paginate) else (),
        if ($perpage ne 10) then concat('perpage=', $perpage) else ()
        )
        , 
        '&amp;')

let $all-results := for $item in collection($data-collection)//term order by $item/name/text() return $item
let $count := count($all-results)
let $results-to-display := if ($paginate eq 'no') then $all-results else subsequence($all-results, $start, $perpage)

let $content := 
    <div>


        { glossary:results-table($results-to-display) }
    </div>

return 
    style:assemble-page($title, $content)