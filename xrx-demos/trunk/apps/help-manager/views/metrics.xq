xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $title :='Help Metrics'
let $resources := collection($data-collection)//resources/resource/resource-type/text()
let $distinct-values := distinct-values($resources)
let $count := count($distinct-values)
let $categories := doc(concat($app-collection, '/code-tables/category-codes.xml'))/code-table

let $content :=
<div class="content">
  <b>Collection: </b>{$app-collection}<br/>
  <table class="span-12">
  <thead>
       <tr>
          <th>Metric</th>
          <th>Value</th>
       </tr>
    </thead>
    <tbody>
        <tr>
           <td class="span-6">Number of Help Items: </td>
           <td class="span-6">{count(collection($data-collection)/help)}</td>
        </tr>
        <tr>
        <td class="span-6">Number of Help Categories: </td>
          <td class="span-5">{count($categories//item )}</td>
        </tr>
        <tr>
           <td class="span-6">Number of Help Resources: </td>
           <td class="span-6">{$count}</td>
        </tr>
    </tbody>
  </table>
  
  
  <table class="span-12">
  <thead>
       <tr>
          <th class="span-6">Category Name</th>
          <th class="span-6">Number of Help Files</th>
       </tr>
    </thead>
    <tbody>
    {
      for $category in $categories//item
        return 
        <tr>
           <td>{$category//label/text()}</td>
           <td>{count(collection($data-collection)/help[./category/text() = $category/value/text()])}</td>
        </tr>
     }
    </tbody>
  </table>
  
 </div>

return style:assemble-page($title, $content)