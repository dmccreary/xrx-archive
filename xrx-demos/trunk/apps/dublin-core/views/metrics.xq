xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'Metrics'
 
let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')

return

<html>
   <head>
      <title>{$title}</title>
     {style:import-css()}
   </head>
   <body>
      {style:header()}
      {style:breadcrumb()}
       <h2>{$title}</h2>
       <b>Data Collection: </b>{$data-collection}<br/>
       <table border="1">
           <thead>
           <tr>
              <th>Metric</th>
              <th>Value</th>
           </tr>
        </thead>
        <tbody>
            <tr>
               <td align="right">Count of Items: </td>
               <td>{count(collection($data-collection)/item)}</td>
            </tr>
          </tbody>
       </table>
       {style:footer()}
   </body>
</html>