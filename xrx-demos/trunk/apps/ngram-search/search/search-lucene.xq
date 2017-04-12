xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := concat('Search results for ', $q)

return
if (not($q)) then
   let $content :=
   <div class="content">
   
      <form method="GET" action="search-lucene.xq">
            <p>
                <strong>Lucene Search:</strong>
                <input name="q" type="text" value="{$q}" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>
     </div>
     return style:assemble-page($title, $content)
else

let $start-time := util:system-time()
 
let $hits :=
 for $hit in collection($data-collection)//record[ft:query(dname, $q)]
   order by $hit/dname/text()
   return $hit
   
let $end-time := util:system-time()
let $runtime := ($end-time - $start-time)
let $runtime := ($runtime div xs:dayTimeDuration('PT1S'))  
        
let $content :=
<div class="content">

      <form method="get" action="search-lucene.xq">
            <p>
                <strong>Lucene Search:</strong>
                <input name="q" type="text" value="{$q}" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>

     
   Lucene search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')} with no indexes.</b>
   Found {count($hits)} in {$runtime} seconds.
     <ol>{
        (: search any column that matchs this string :)
        for $hit at $counter in $hits
        return
           <li>{$hit/dname/text()}</li>
      }</ol>
    
</div>

return style:assemble-page($title, $content)
