import module namespace style = "http://example.com/style" at "style.xqm";

let $title := 'Page Title'
let $content :=
<div class="content">
   <p>Hello World</p>
</div>

return style:assemble-page($title, $content)
