xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := "User Search Results"

let $content :=
<div class="content">

        <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b></p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//user[contains(*, $q)]
        order by ft:score($hit) descending
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/person-given-name/text()}</a> {' '} {$hit/person-family-name/text()}</li>
      }</ol>
       <form method="GET" action="search-contains.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>
 
</div>

return style:assemble-page($title, $content)
