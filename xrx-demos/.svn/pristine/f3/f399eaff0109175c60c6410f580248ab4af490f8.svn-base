xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Search User Stories'
(: the search query string :)
let $q := request:get-parameter('q', '')

let $content :=
<div class="content">
     <p><b>Search results for: </b>{$q} <b> In collection: </b>{$data-collection}</p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)/UseCase[contains(* ,$q)]
        order by ft:score($hit) descending
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}">{$hit/UseCaseName/text()}</a>
           {' '} {$hit/UseCaseGoalText/text()}
           </li>
      }</ol>

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

return
    style:assemble-page($title, $content)
