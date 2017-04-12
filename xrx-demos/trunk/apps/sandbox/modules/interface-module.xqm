xquery version "1.0";

module namespace sandbox = "http://danmccreary.com/sandbox";

declare function sandbox:get-select($id as xs:string) as node () {
let $queries := collection('/db/dma/apps/sandbox/data')/example-queries[id=$id]/query
return
<select id="saved" name="saved">
    <option value="Select a query..."></option>
    {
    for $query in $queries
    return
        <option value="{$query/code/text()}">{$query/description/text()}</option>
    }
</select>
};

declare function sandbox:results-table($results-to-display as node()*) as node() {
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>File Name</th>
                <th>View</th>
            </tr>
        </thead>
        <tbody>{
            for $item in $results-to-display
                let $id := $item/id/text()
                let $document-name := util:document-name($item)
                let $name := $item/description/text()
                
                let $category := $item/category/text()
                let $status := $item/status/text()
                let $tag := $item/tag/text()
                order by xmldb:last-modified(util:collection-name($item), $document-name) descending
                return
                    <tr>
                        <td>{$id}</td>
                        <td><a href="http://demo.danmccreary.com/rest/dma/apps/sandbox/sandbox.xql?id={$id}">{$name}</a></td>
                        <td>{$document-name}</td>

                        <td><a href="{concat('/rest/db/dma/apps/sandbox/views/view-item.xq?id=', $id)}">View</a></td>                   
                    </tr> 
        }</tbody>
    </table>
};