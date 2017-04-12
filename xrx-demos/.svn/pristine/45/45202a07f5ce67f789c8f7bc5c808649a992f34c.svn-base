xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace xhtml="http://www.w3.org/1999/xhtml";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')
let $title :='Task Search Results'
return

let $content :=
<div class="content">

        <p>Search results for query: "<b>{$q}</b>" In collection: <b>{substring-after($data-collection, 'xmldb:exist://')}</b></p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//task[contains(*, $q)]
        order by ft:score($hit)
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/task-name/text()}</a> {' '} {$hit/task-description/text()}</li>
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





