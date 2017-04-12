xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare function local:max-length($string-seq as xs:string*) as xs:string* {
  let $max := max (for $s in  $string-seq  return string-length($s))
  return $string-seq[string-length(.) = $max]
};
 
let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $code-table-file := concat($app-collection, '/code-tables/projectss.xml')

return

<html>
   <head>
      <title>Pattern Metrics</title>
     {style:import-css()}
   </head>
   <body>
      {style:header()}
      {style:breadcrumb()}
       <h1>Pattern Metrics</h1>
       <b>Collection: </b>{$app-collection}<br/>
       <b>Code Table: </b>{$code-table-file}
       <table border="1">
           <thead>
           <tr>
              <th>Metric</th>
              <th>Value</th>
           </tr>
        </thead>
        <tbody>
            <tr>
               <td align="right">Count of Pattern: </td>
               <td>{count(collection($data-collection)/Pattern)}</td>
            </tr>
             <tr>
               <td  align="right">Count of Project Categories:</td>
               <td>{count( doc($code-table-file)/code-table/items/item )}</td>
            </tr>
             <tr>
               <td  align="right">Longest name:</td>
               <td>{local:max-length(collection($data-collection)/Pattern/PatternName/text())}</td>
            </tr>
             <tr>
               <td  align="right">Longest Pattern Description:</td>
               <td>{local:max-length(collection($data-collection)/Pattern/Description/text())}</td>
            </tr>
          </tbody>
       </table>
       {style:footer()}
   </body>
</html>