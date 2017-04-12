xquery version "1.0";

(: Search Volumes form + results :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";
import module namespace glossary = "http://syntactica.com/apps/glossary" at "../modules/glossary-module.xqm";

declare namespace hist="http://history.state.gov/ns/1.0";

let $data-collection := $style:db-path-to-app-data

let $paginate := request:get-parameter('paginate', 'yes')
let $start := xs:integer(request:get-parameter('start', 0))
let $perpage := xs:integer(request:get-parameter('perpage', 10))

(: the search query string :)
let $q := request:get-parameter('q', '')

(: style:paginated-list-links() constructs links to each page of results; 
 : it handles the $start parameter, so we need to pass any other parameters 
 : to it via a $url-params :)
let $url-params := 
    string-join(
        (
        if ($paginate ne 'yes') then concat('paginate=', $paginate) else (),
        if ($perpage ne 10) then concat('perpage=', $perpage) else (),
        if ($q) then concat('q=',$q) else()
        )
        , 
        '&amp;')


(: lucene search for children of volume elements that match this string :)
let $hits := if ($q) then collection($data-collection)/term[ft:query(*, $q)] else ()
let $count := count($hits)
let $hits-to-display := if ($paginate eq 'no') then $hits else subsequence($hits, $start+1, $perpage)

let $form := 
    <form method="GET" action="search">
        <strong>Search:</strong>
        <input name="q" type="text" value="{$q}" size="60" title="Search volume metadata."/>
        <input type="submit" value="search"/>
    </form>

let $content := 
 <div>
        <p>{
            if ($paginate eq 'no') then 
                (
                concat('All ', $count, ' items, sorted by ID. ')
                ,
                <a href="?paginate=yes&amp;q={$q}">(Show only first {$perpage}.)</a>
                )
            else
                (
                concat(
                    style:how-many-on-this-page($start, $perpage, $count, 'items')
                    ,
                    '. '
                    )
                ,
                if ($count le $perpage) then () else <a href="?paginate=no&amp;q={$q}">(Show all.)</a>
                )
        }</p>
        
        {
        if ($paginate eq 'no') then 
            () 
        else 
            (
            style:paginated-list-links($start, $perpage, count($hits), $url-params)
            ,
            <hr class="space"/>
            )
        }
    <div id="searchform">
        {$form}
        {
        if ($q and count($hits) gt 0) then 
            (
            <p><strong>Search results for: </strong>{$q}<strong> In collection: </strong>{$data-collection}</p>
            ,
            glossary:results-table($hits-to-display)
            ,
            $form
            )
        else if ($q) then
            <p><strong>No search results for: </strong>{$q}<strong> In collection: </strong>{$data-collection}</p>
        else ()
        }
    </div>
      {
        if ($paginate eq 'no') then 
            () 
        else 
            (
            style:paginated-list-links($start, $perpage, count($hits), $url-params)
            ,
            <hr class="space"/>
            )
        }
    
    
</div>    
return 
    style:assemble-page($content)