xquery version "1.0";

(: List XQuery Example Sets :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace sandbox = "http://danmccreary.com/sandbox" at "../modules/interface-module.xqm";

let $title := 'Test Data Sets'

let $data-collection := $style:db-path-to-app-data

let $paginate := request:get-parameter('paginate', 'yes')
let $start := xs:integer(request:get-parameter('start', 0))
let $perpage := xs:integer(request:get-parameter('perpage', 10))

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

let $all-results := for $item in collection($data-collection)/example-queries order by xs:integer($item/id) return $item
let $count := count($all-results)
let $results-to-display := if ($paginate eq 'no') then $all-results else subsequence($all-results, $start, $perpage)

let $content := 
    <div>
        <p>Query Sets from {$data-collection} sorted by last-modified date.</p>
        
    
        { sandbox:results-table($results-to-display) }
    
        

    </div>

return 
    style:assemble-page($title, $content)