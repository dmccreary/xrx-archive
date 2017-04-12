xquery version "1.0";
import module namespace style = "http://www.danmccreary.com/library" at "../../../modules/style.xqm";
declare default element namespace "http://www.loc.gov/mods/v3";

let $page-title := 'Add Identifier to all MODS records'

let $data-collection := $style:db-path-to-app-data
let $ids := collection($data-collection)//mods/identifier/text()
let $max-id := max($ids)

let $content := 
    <div class="content">
       <h1>{$page-title}</h1>
       <p>This program will go through all the MODS records in the input collection and add an identifier element
       to each modes record preciding the firt titleInfo element.</p>
       <p>Collection: {$data-collection}</p>
       <ol>
       max = {$max-id}<br/>
       {
         for $item at $count in collection($data-collection)//mods[not(identifier)]
            let $title := $item/titleInfo/title[1]/text()
            let $update := update insert <identifier>{$max-id+$count}</identifier> preceding $item/titleInfo[1]
            order by $title
            return
               <li>id={$max-id+$count} <a href="view-item.xq?id={$max-id+$count}">{$title}</a> <a href="../views/get-instance.xq?id={$max-id+$count}">XML</a></li>
               
      }</ol>
</div>

return style:assemble-page($page-title, $content)

