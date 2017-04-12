xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
(: save-new.xq :)
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection , '/data')
let $title := 'List Data Elements'

let $content :=
<div class="content">

        <p><b>Report generation date-time: </b> {current-dateTime()}.  <b>Sort:</b> Case insensitive alphabetical by data-element.</p>
        <table border="1">
            <thead>
              <tr>
                  <th>Name (Superclass)</th>          
                  <th>Definition</th>
                  <th>Status</th>
                  <th>Tags</th>
              </tr>
         </thead>
         <tbody>{
    for $my-data-element in collection($data-collection)/DataElement
       let $data-element := $my-data-element/DataElementName/text()
       let $definition := $my-data-element/DataElementDefinitionText/text()
       let $complex := $my-data-element/DataElementComplexIndicator/text()
       let $object-class :=$my-data-element/DataElementObjectClassName/text()
       let $subclass-of :=  $my-data-element/DataElementSubClassOf/text()
       let $parent := if ($complex='true')
          then ($subclass-of)
          else ($object-class)
       let $subclass-of :=  $my-data-element/DataElementSubClassOf/text()
       let $status := $my-data-element/DataElementApprovalStatusCode/text()
       let $classifier := $my-data-element/ClassifierCode[1]/text()
       let $tag := $my-data-element/Tag[1]/text()
       order by upper-case($data-element)
    return
    <tr>
       <td><a href="view-item.xq?id={$data-element }">{$data-element}</a> (<a href="view-item.xq?id={$parent}">{$parent}</a>)</td>
       <td>{$definition}</td>
       <td>{$status}</td>
       <td>{$classifier}</td>
       <td>{$tag}</td>
    </tr>
          }</tbody>
       </table>
</div>

return style:assemble-page($title, $content)
