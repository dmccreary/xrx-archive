xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Search XML Schemas'

let $content := 
<div class="content">
    <h1>{$title}</h1>

        <form method="GET" action="documentation-search.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>

</div>

return style:assemble-page($title, $content)