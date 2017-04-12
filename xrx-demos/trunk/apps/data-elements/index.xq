xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'List Data Elements'

let $content :=
<div class="content">
       
        <h1>Data Element Manager</h1>
        <p>Under Construction</p>
        <ol>
            <li>
                <a href="views/list-items.xq">List</a> List of all Data Elements
            </li>
            
            <li>
                <a href="edit/edit.xq?new=true">New</a> Create New Data Elements
            </li>
            <li>
                <a href="search/search-form.xq">Search</a> Search Data Elements
            </li>
            <li>
                <a href="views/metrics.xq">Metrics</a> Counts of various Data Elements Metrics
            </li>
        </ol>
        <h1>Import of Spreadsheets</h1>
        <ol>
            <li>
                <a href="views/list-base-objects.xq">Base Objects</a> List of all Base Objects
            </li>
            <li>
                <a href="views/list-context-objects.xq">Context Objects</a> List of all Context Objects
            </li>
            <li>
                <a href="views/list-product-objects.xq">Products Objects</a> List of all Products Objects
            </li>
        </ol>

</div>

return style:assemble-page($title, $content)