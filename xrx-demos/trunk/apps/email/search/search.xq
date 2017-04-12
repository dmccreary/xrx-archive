xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Email Search Results'
let $data-collection := $style:db-path-to-app-data
let $q := request:get-parameter('q', "")

(: put the search results into memory using the eXist any keyword ampersand equals comparison :)
let $search-results := collection($data-collection)//message[contains(*, $q)]
let $count := count($search-results)

let $content :=
<div class="content">
        <h3>E-mail Search Results</h3>
        <p><b>Search results for:</b>&quot;{$q}&quot; <b> In Collection: </b>{$data-collection}</p>
        <p><b>Terms Found: </b>{$count}</p>
     <ol>{
           for $message in $search-results
              let $id := $message/id
              let $subject := $message//subject/text()
          return
            <li>
               <a href="../views/view-item.xq?id={$id}">{$subject}</a>
            </li>
      }</ol>
      
    <div class="content">
        <form method="GET" action="search.xq">
            <b>Search:</b>
            <input name="q" type="text" value="" size="30"/>
            <input type="submit" value="Search"/>
        </form>
    </div>
</div>

return style:assemble-page($title, $content)
