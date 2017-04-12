xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace u = "http://danmccreary.com/faq" at "../modules/faq-module.xqm";

let $title := 'List FAQ Items'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-items := doc(concat($app-collection, "/code-tables/faq-category-codes.xml"))//item

let $content :=
<div class="content">
       <table>
           <thead>
           <tr>
              <th>ID</th>
              <th>Category</th>
              <th>Question</th>
              <th>View</th>
           </tr>
        </thead>
        <tbody>{
          for $item in collection($data-collection)/faq
             let $id := $item/id/text()
          return
             <tr>
                <td>{$item/id/text()}</td>
                <td>{string-join(u:category-labels($id), ', ')}</td>
                
               
                <td>{$item/question/text()}</td>            
                 <td><a href="view-item.xq?id={$id}">View</a></td>
             </tr> 
       }</tbody></table>
</div>

return style:assemble-page($title, $content)