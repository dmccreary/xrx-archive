xquery version "1.0";
import module namespace style = "http://style.syntactica.com/ibm" at "/db/cust/ibm/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

(: list all the data in a given taxonomy file :)


let $file := request:get-parameter('file', 'rss-feeds.xml')
let $id := request:get-parameter('id', '')

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
let $doc := doc($doc-path)/taxonomy
let $classifier := $doc/classifier[id=$id]

return
(: check for required parameters :)
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing. It is required for this view.</message>
    </error>)
    else
<html>
   <head>
      <title>Classifier</title>
      {style:import-css()}
   </head>
   <body>
      {style:header()}
      {style:breadcrumb()}
      <h1>List Items</h1>
       <table>
           <thead>
           <tr>
              <th>Attrribute</th>
              <th>Value</th>
           </tr>
        </thead>
        <tbody>
             <tr>
                 <th align="right">Label: </th>
                 <td>{$classifier/classifier-label/text()}</td>
             </tr>
             <tr>
                 <th align="right">ID:</th>
                 <td>{$classifier/id/text()}</td>
             </tr>
             <tr>
                 <th align="right">Parent ID:</th>
                 <td>{$classifier/parent-id/text()}</td>
             </tr>
             <tr>
                 <th align="right">Color: </th>
                 <td>{$classifier/color/text()}</td>
             </tr> 
       </tbody></table>
       <a href="../edit/edit.xq?id={$id}">Edit</a>
       <a href="../edit/delete-confirm.xq?id={$id}">Delete</a>
   </body>
</html>