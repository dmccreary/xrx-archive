xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-name := 'jiem-conditions.xml'
let $doc := concat($data-collection, '/', $doc-name)

let $title :='List JIEM Conditions'

let $content :=
<div class="content">
        <table>
         <thead>
           <tr>
              <th>Subject</th>
              <th>Predicate</th>
              <th>Description</th>
           </tr>
        </thead>
        <tbody>{
          for $item in doc($doc)/conditions/condition
             let $subject := string($item/@subject)
             order by $subject
          return
             <tr>
                 <td>{$subject}</td>
                 <td>{string($item/@predicate)}</td>
                  <td>{string($item/@description)}</td>
             </tr> 
       }</tbody>
       </table>
       
</div>
 return style:assemble-page($title, $content) 
