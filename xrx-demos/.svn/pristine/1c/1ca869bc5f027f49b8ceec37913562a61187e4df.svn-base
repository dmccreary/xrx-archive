xquery version "1.0";

module namespace glossary = "http://danmccreary.com/glossary";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare function glossary:results-table($results-to-display as node()*) as node() {

let $ordered-terms :=
   for $item in $results-to-display
   order by $item/term-name/text()
   return $item

return
    <table>
        <thead>
            <tr>
                <th>Term</th>
                <th>Abbreviation</th>
                <th>Definition</th>
            </tr>
        </thead>
        <tbody>{
            for $item at $count in $ordered-terms

            let $name := $item/term-name/text()
            let $id := $item/id/text()
            let $definition := $item/definition/text()
            let $status := $item/approval-status-code/text()
            let $author := $item/author-code/text()
            order by $name
            return
                <tr> {if ($count mod 2) then attribute {'bgcolor'} {'lavender'} else ()}
                    <td><a href="view-item.xq?id={$id}">{$name}</a></td>
                    <td>{$item/abbreviation/text()}</td>
                    <td>{$definition}</td>
                </tr> 
        }</tbody>
    </table>
};

declare function glossary:results-table-full($results-to-display as node()*) as node() {
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Definition</th>
                <th>Status</th>
                <th>Author</th>
            </tr>
        </thead>
        <tbody>{
            for $item in $results-to-display
            let $id := $item/id/text()
            let $name := $item/name/text()
            let $definition := $item/definition/text()
            let $status := $item/approval-status-code/text()
            let $author := $item/author-code/text()
            return
                <tr>
                    <td><a href="view-item?id={$id}" title="{$id}">{$name}</a></td>
                    <td>{$definition}</td>
                    <td>{$status}</td>
                    <td>{$author}</td>
                </tr> 
        }</tbody>
    </table>
};