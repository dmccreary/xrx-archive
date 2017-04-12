xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";
declare option exist:output-size-limit "50000";

let $app-collection := style:app-base-uri()
let $import-collection := concat($app-collection, '/ss-import')
let $doc := concat($import-collection, '/product-objects.xml')

return
<html>
   <head>
       <title>Product Objects</title>
       {style:import-css()}
    </head>
    <body>
       {style:header()}
       {style:breadcrumb()}
       <h1>Product Objects</h1>
       <p>Product objects are ...need defintion.</p>
       <b>Total Count:</b>{count(doc($doc)/Objects/Object)}
       <table class="small-font">
          <thead>
             <tr>
                 <td>Object (Subclass)</td>
                 <td>Contains</td>
                 <td>Rep. Term</td>
                 <td>Description</td>
                 <td>Property</td>
                 <td>Type</td>
                 <td>Comment</td>
             </tr>
          </thead>
          <tbody>{
           for $object at $count in doc($doc)/Objects/Object
           return
             <tr> {if (exists($object/Object/text())) then (attribute {'bgcolor'} {'silver'}) else ()}
                <td>{$object/Object/text()} 
                {if (string-length($object/subclassOf/text()) > 1)
                   then (concat('(', $object/subclassOf/text(), ')'))
                   else () }</td>
                <td>{$object/contains/text()}</td>
                <td>{$object/RepresentationTerm/text()}</td>
                <td>{$object/DescriptionText/text()}</td>
                <td>{$object/Property/text()}</td>
                <td>{$object/Type/text()}</td>
                <td>{$object/Comments/text()}</td>
             </tr>
            }</tbody>
         </table>
        {style:footer()}
    </body>
 </html>
