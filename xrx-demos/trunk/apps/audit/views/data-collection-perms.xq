xquery version "1.0";

(: View Permissions on all data collections :)

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
(: Converts a non-Negative Integer to Octal :)

declare function local:int-to-oct($in as xs:integer) as xs:string {
if ($in eq 0)
   then '0' 
   else
       concat(
           if ($in ge 8)
                then local:int-to-oct($in idiv 8)
                else ''
        ,
            substring('01234567', ($in mod 8) + 1, 1)
       )
};

let $title := 'App Data Collection permissions'

let $root-collection := concat($style:db-path-to-site, '/apps')

(: create a sorted sequence of apps :)
let $apps := 
  for $app in xmldb:get-child-collections($root-collection)
  order by $app
  return $app
  
let $content :=
<div class="content">
   Looking for all data collections under {substring-after($root-collection, 'xmldb:exist://')}/*<br/>
   <table class="span-16 last">
      <thead>
         <tr>
           <th class="span-4">App ID</th>
           <th class="span-2">Owner</th>
           <th class="span-2">Group</th>
           <th class="span-2">Decimal</th>
           <th class="span-2">Octal</th>
           <th class="span-2">String</th>
           <th class="span-2 last">Sub-Collections</th>
         </tr>
      </thead>
    {for $app at $count in $apps
       let $app-collection := concat($root-collection, '/', $app)
       let $data-collection := concat($app-collection, '/data')
       return
          if (xmldb:collection-available($data-collection))
          then
           <tr>
             {if ($count mod 2)
                then attribute class {'odd'}
                else attribute class {'even'}
             }
             <td>{$app}</td>
             <td text-align="center">{xmldb:get-owner($data-collection)}</td>
             <td text-align="center">{xmldb:get-group($data-collection)}</td>
             <td text-align="center">{xmldb:get-permissions($data-collection)}</td>
             <td text-align="center">{local:int-to-oct(xmldb:get-permissions($data-collection))}</td> 
             <td text-align="center">{xmldb:permissions-to-string(xmldb:get-permissions($data-collection))}</td>
             <td  text-align="center">{
             if ( exists(xmldb:get-child-collections($data-collection)) ) then 'Yes' else 'No'
              }</td>
           </tr>
           else
           <tr>
             {if ($count mod 2)
                then attribute class {'odd'}
                else attribute class {'even'}
             }
             <td>{$app}</td>
             <td colspan="6">No Data Collection</td>
           </tr>
         
    }
  </table>
</div>
        
return style:assemble-page($title, $content)