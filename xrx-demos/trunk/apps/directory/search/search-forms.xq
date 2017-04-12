xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Search Forms'

let $content := 
<div class="content">
    <h1>{$title}</h1>
    <a href="search-form.xq">Fulltext Search</a><br/>

    <a href="contains-search-form.xq">Contains Search</a><br/>
</div>

return style:assemble-page($title, $content)