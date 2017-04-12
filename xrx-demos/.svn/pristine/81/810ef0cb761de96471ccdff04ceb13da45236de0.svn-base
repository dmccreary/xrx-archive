xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

(: echo a list of all the URL parameters  :)
let $parameters :=  request:get-parameter-names()
let $title := 'View Parameters From URL'
 
let $content :=
<div class="content">
   <table class="span-6">
      <thead>
         <tr>
           <th class="span-3">Parameter Name</th>
           <th class="span-3 last">Value</th>
         </tr>
      </thead>
      <tbody>
        {for $parameter in $parameters
            return
            <tr>
               <th>{$parameter}</th>
               <td>{request:get-parameter($parameter, '')}</td>
            </tr>
         }    
    </tbody>
    </table>
</div>

return style:assemble-page($title, $content)
