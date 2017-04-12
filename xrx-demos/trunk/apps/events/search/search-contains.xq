xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := $style:db-path-to-app-data

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := concat('Search results for ', $q)

let $content :=
<div class="content">

        <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b></p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//event[contains(*, $q)]
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/Excerpt_Description/text()}</a></li>
      }</ol>
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

return style:assemble-page($title, $content)
