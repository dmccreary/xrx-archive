xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='search'
(: the search query string :)
let $q := request:get-parameter('q', '')

let $hits := if ($q) then collection($data-collection)/faq[contains(*, $q)] else ()

let $content :=
<div class="content">
     <h2>Search Results</h2>
     <p><b>Search results for: </b>{$q} <b> In collection: </b>{$data-collection}</p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)/Requirement[contains(* ,$q)]
        order by ft:score($hit) descending
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/RequirementShortName/text()}</a>
           {' '} {$hit/RequirementDescriptionText/text()}
           </li>
      }</ol>
      
      <form method="GET" action="search.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>
</div>                                           

return
    style:assemble-page($title, $content)
