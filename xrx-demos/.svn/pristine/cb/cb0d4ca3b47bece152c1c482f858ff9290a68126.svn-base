xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare function local:max-length($string-seq as xs:string*) as xs:string* {
  let $max := max (for $s in  $string-seq  return string-length($s))
  return $string-seq[string-length(.) = $max]
};

let $title := "User Stories Metrics"
 
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')


let $content := 
<div class="content">
       <b>Collection: </b>{$app-collection}<br/>
       <table class="span-10 last">
           <thead>
           <tr>
              <th class="span-5">Metric</th>
              <th class="span-1 last">Value</th>
           </tr>
        </thead>
        <tbody>
            <tr>
               <td align="right">Number of User Stories: </td>
               <td>{count(collection($data-collection)/UseCase)}</td>
            </tr>
          </tbody>
       </table>
 </div>

return 
    style:assemble-page($title, $content)