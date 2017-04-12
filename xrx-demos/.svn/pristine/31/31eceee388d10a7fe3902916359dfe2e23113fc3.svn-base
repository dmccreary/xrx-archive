xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";
let $id := request:get-parameter('id', '')

let $title := 'View FAQ'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $item := collection($data-collection)/faq[id = $id]
(:let $faq-category-codes :=concat($app-collection,'/',"code-tables/faq-category-codes.xml")//item
:)
let $content :=
<div class="content">
   
         <table class="span-12">
             <tr><td>ID:</td><td>{$item/id/text()}</td></tr>
             <tr><td>Question:</td><td>{$item/question}</td></tr>
             <tr><td>Answer:</td><td>{$item/answer}</td></tr>
          </table>
      
    {style:revision-status-table($item)} 
    {style:edit-controls($id)}
    
</div>

return style:assemble-page($title, <span><a href="list-items.xq">List Items</a></span>, (), $content)

       