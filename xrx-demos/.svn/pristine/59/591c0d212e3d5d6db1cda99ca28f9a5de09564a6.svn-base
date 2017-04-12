xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := concat('Book search results for ', $q)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $start-time := util:system-time()

let $hits :=
   for $hit in collection($data-collection)//book[contains(*, $q)]
      return $hit

let $end-time := util:system-time()


let $run-time-ms := (($end-time - $start-time) div xs:dayTimeDuration('PT1S'))  * 1000

let $content :=
<div class="content">
   
    <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b>
    {count($hits)} hits in {$run-time-ms} milliseconds</p>
       {
        (: search any column that matchs this string :)
        for $hit in $hits
            let $id := $hit/id/text()
            let $score := ft:score($hit)
            order by $score descending
            return
               <div class="hit">
                 <a href="../views/view-item.xq?id={$id}">{$hit/title/text()} </a> 
               </div>
         }    

<br/><br/>

<div class="content">
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
</div>

return style:assemble-page($title, $content)
