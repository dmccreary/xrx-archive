xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $app-collection := style:app-base-uri()
let $import-collection := concat($app-collection, '/ss-import')

let $product-doc := concat($import-collection, '/product-objects.xml')
let $context-doc := concat($import-collection, '/context-objects.xml')
let $base-doc := concat($import-collection, '/base-objects.xml')

return
<html>
  <head>
     <title>Data Element Metrics</title>
     {style:import-css()}
   </head>
   <body>
     {style:header()}
     {style:breadcrumb()}
     <h1>Data Element Metrics</h1>
      
     <h1>Import Spreadsheet Objects</h1>
     <b>Total Product Objects:</b>{count(doc($product-doc)/Objects/Object)}<br/>
     <b>Total Context Objects: </b>{count(doc($context-doc)/Objects/Object)}<br/>
     <b>Total Base Objects: </b>{count(doc($base-doc)/Objects/Object)}<br/>
     {style:footer()}
   </body>
</html>