xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := concat('Search Full Text Results for: ', $q)

let $content :=
<div class="content">

        <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b></p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//user[ft:query(*, $q)]
        order by ft:score($hit) descending
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/person-given-name/text()}</a> {' '} {$hit/person-family-name/text()}</li>
      }</ol>
     
    <div class="edit-controls">     
      <a href="search-fulltext-form.xq">New Search</a>
      <a href="../views/list-items.xq">List Items</a>
      <a href="../index.xq">Main Menu</a>
    </div>
</div>

return style:assemble-page($title, $content)
