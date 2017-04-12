xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $category := request:get-parameter('category', '')

let $title :=
   if ($category)
      then concat('All Animals in Category ', $category)
      else 'All Available Animals'

let $app-collection := $style:db-path-to-app

let $animals :=
   if ($category)
      then collection($style:db-path-to-app-data)/animal[./animal-category-code/text() = $category]
      else collection($style:db-path-to-app-data)/animal

let $content :=
<div class="content">
    <ol>
    {for $animal in $animals
        let $id := $animal/id/text()
        order by $id
        return
           <li><a href="view-animal.xq?id={$id}">
             {$animal/animal-name/text()}</a> ({$animal/animal-type-code/text()}) {$animal/pruchase-amount/text()}
           </li>
     }
     </ol>
     
     <a href="all-animals-in-category.xq">List All</a>
</div>

return style:assemble-page($title, $content)