xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace kwic="http://exist-db.org/xquery/kwic";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $config := <config xmlns="" width="60"/>

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := concat('Search results for ', $q)

let $content :=
<div class="content">
    <style type="text/css"><![CDATA[
       .hi {color:blue;font-weight:bold;}
    ]]></style>

    <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b></p>
       {
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//*[ft:query(*, $q)]
            let $id := $hit/id/text()
            let $score := ft:score($hit)
            let $matches := kwic:get-matches($hit)
            let $summary := kwic:summarize($hit, $config)
            order by $score descending
            return
               <div class="hit">
                 <a href="../views/view-item.xq?id={$id}">{$hit/name/text()}</a>
                 {$summary}
               </div>
         }     
   <div id="searchform">
        <form method="GET" action="search.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>
     </div>
</div>

return style:assemble-page($title, $content)
