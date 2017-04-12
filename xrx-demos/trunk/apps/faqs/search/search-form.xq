xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'FAQ Search'
let $content :=
<div class='content'>
  <div id="searchform">
    <form method="GET" action="search.xq">
      <p>
        <strong>Search:</strong>
        <input name="q" type="text" value=""/>
        <input type="submit" value="Search"/>
      </p>
    </form>
  </div>
</div>

return style:assemble-page($title, $content)