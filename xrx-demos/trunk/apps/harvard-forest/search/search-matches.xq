xquery version "1.0";
import module namespace kwic="http://exist-db.org/xquery/kwic";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare option exist:serialize "highlight-matches=both";

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
        for $hit in collection($data-collection)//item[ft:query(*, $q)]
        let $score := ft:score($hit)
        let $matches := kwic:get-matches($hit)
        let $summary := kwic:summarize($hit, $config)

         order by $score descending
        
        return $summary
         }     
       
      
      
      <a href="search-form.xq">New Search</a>
      <a href="../edit/edit.xq?new=true">Create New Item</a>
      <a href="../views/list-items.xq">List Items</a>
</div>

return style:assemble-page($title, $content)
