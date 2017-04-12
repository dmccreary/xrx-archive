xquery version "1.0";

(: List All Plays in the Collection :)

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare default element namespace "http://www.tei-c.org/ns/1.0";

let $data-collection := $style:db-path-to-app-data  (: $style:db-path-to-app-data :)

let $title := 'Play List'
(: Create a sequence of all the TEI documents that have a castlist :)
let $plays := collection($data-collection)/TEI[*//castList]

let $content :=
<div class="content">

    <p>Ordered by Title</p>
    
    <!-- create an order list of items -->
    <ol>
       { (: for each play create a list item with a link to the play viewer :)
            for $play in $plays
            (: get the play ID :)
            let $id := string($play/@xml:id)
            let $title := $play//titleStmt/title/text()
            order by $title
            return
            <li>
               <a href="view-play.xq?id={$id}">{$title}</a>
            </li>
        }
     </ol>
</div>

return 
    style:assemble-page($title, $content)