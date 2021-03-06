xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')

let $title := 'Feeedback Search Results'
let $content :=
  <div class="content">
        <p>Search results for query: "<b>{$q}</b>" In collection: <b>{$data-collection}</b></p>
         <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)//feedback[ft:query(*, $q)]
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}"></a> {$hit/description/text()}</li>
      }</ol>
      
      <a href="search-form.xq">New Search</a>
      <a href="../edit/edit.xq?new=true">Create New Item</a>
      <a href="../views/list-items.xq">List Items</a>
  </div>

return style:assemble-page($title, $content)
