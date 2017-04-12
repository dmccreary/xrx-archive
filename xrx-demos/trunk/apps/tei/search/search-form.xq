xquery version "1.0";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
let $title :='Play Search'
let $content :=
<div class="content">
   <form method="GET" action="search.xq">
        <b>Search:</b>
        <input name="q" type="text" value="" size="30"/>
        <input type="submit" value="Search"/>
   </form>
</div>

return

style:assemble-page($title, $content)