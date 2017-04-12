xquery version "1.0";
import module namespace style = "http://style.syntactica.com/ibm" at "/db/cust/ibm/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

(: list all the data in a given taxonomy file :)

let $file := request:get-parameter('file', 'rss-feeds.xml')

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
let $doc := doc($doc-path)/taxonomy
return

<html>
   <head>
      <title>List Classifiers</title>
      {style:import-css()}
   </head>
   <body>
      {style:header()}
      {style:breadcrumb()}
      <h1>List Items</h1>
       <table>
           <thead>
           <tr>
              <th>Metric</th>
              <th>Value</th>
           </tr>
        </thead>
        <tbody>
             <tr>
                 <th>Number of Classifiers</th>
                 <td>{count($doc/classifier)}</td>
             </tr>
             <tr>
                 <th>Number of Colors</th>
                 <td>{count($doc/classifier/color)}</td>
             </tr> 
       </tbody></table>
  
   </body>
</html>