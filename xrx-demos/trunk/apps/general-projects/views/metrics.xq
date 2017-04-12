xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

declare function local:max-length($string-seq as xs:string*) as xs:string* {
  let $max := max (for $s in  $string-seq  return string-length($s))
  return $string-seq[string-length(.) = $max]
};
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $code-table-status-file := concat($app-collection, '/code-tables/development-status-code.xml')
let $code-table-role-file := concat($app-collection, '/code-tables/project-role-code.xml')
let $title :='Project Metrics'

let $content :=
<div class="content">
       <b>Collection: </b>{$app-collection}<br/>
       <b>Code Table: </b>{$code-table-status-file}
       <br/>
       <b>Code Table: </b>{$code-table-role-file}
       <table border="1">
           <thead>
           <tr>
              <th>Metric</th>
              <th>Value</th>
           </tr>
        </thead>
        <tbody>
            <tr>
               <td align="right">Count of Projects: </td>
               <td>{count(collection($data-collection)/GeneralProject)}</td>
            </tr>
             <tr>
               <td  align="right">Count of Development Status Codes:</td>
               <td>{count( doc($code-table-status-file)/code-table/items/item )}</td>
            </tr>
             <tr>
               <td  align="right">Count of Project Role Codes:</td>
               <td>{count( doc($code-table-role-file)/code-table/items/item )}</td>
            </tr>
         </tbody>
       </table>
</div>
   return style:assemble-page($title, $content)