xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Search Directory'

let $content := 
<div class="content">

<p>The following search does an exact match for all names that contain the following string</p>
        <form method="GET" action="search-contains.xq">
            <p>
                <strong>Search:</strong>
                <input name="q" type="text" value="" size="60"/>
                <input type="submit" value="Search"/>
            </p>
        </form>

</div>

return style:assemble-page($title, $content)