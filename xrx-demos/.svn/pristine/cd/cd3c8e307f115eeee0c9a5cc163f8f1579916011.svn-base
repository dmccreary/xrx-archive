xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Browse By Animal Category'

let $app-collection := $style:db-path-to-app
let $animal-categories-path := concat($app-collection, '/code-tables/animal-category-codes.xml')
let $animal-categories := doc($animal-categories-path)//item
let $animals := collection($style:db-path-to-app-data)/animal

let $content :=
<div class="content">
    <ol>
    {for $item in $animal-categories
        let $label := $item/label/text()
        let $value := $item/value/text()
        order by $label
        return
           <li>
             <a href="all-animals-in-category.xq?category={$value}">{$label}</a> 
             items in this category = {count($animals[animal-category-code/text() = $value])}
           </li>
     }
     </ol>
     Total animals in collection := {count($animals)}<br/>
     
     <a href="all-animals-in-category.xq">List All</a>
</div>

return style:assemble-page($title, $content)