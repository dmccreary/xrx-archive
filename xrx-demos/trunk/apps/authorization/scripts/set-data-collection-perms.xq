xquery version "1.0";

(: Get a list of the data collections :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

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

let $root-collection := concat($style:db-path-to-site, 'apps')

(: create a sequence of collections of the data collections we must set permission on :)
let $write-collections :=
<collections>
    {for $app in xmldb:get-child-collections($root-collection)
       let $app-collection := concat($root-collection, '/', $app)
       let $data-collection := concat($app-collection, '/data')
       order by $app
       return
          if (xmldb:collection-available($data-collection))
          then
                (<collection>{$data-collection}</collection>
                ,
               
                if (xmldb:collection-available(concat($data-collection, '/images')))
                  then <collection>{$data-collection}/images</collection>
                  else ()
                ,
                  
                 if (xmldb:collection-available(concat($data-collection, '/a')))
                  then for $i in ( string-to-codepoints('a') to string-to-codepoints('z') )
                       order by $i
                       return
                          if (xmldb:collection-available(concat($data-collection, '/', codepoints-to-string($i))))
                            then <collection>{$data-collection}/{codepoints-to-string($i)}</collection>
                            else ()
                           
                  else ()
                  
                )
          else ()
     }
</collections>

let $update :=
  for $collection in $write-collections//collection/text()
   return xmldb:set-collection-permissions($collection, 'admin', 'cms-edit', util:base-to-integer(0774, 8) )
   
let $count := count($write-collections//collection)

let $content :=
<div class="content">
    <p>A list of all collections that CMS users (edit, publish) must be able to write to.</p>
    Root collection := {$root-collection} <br/>
    Collection Count = {$count}<br/>
    <table class="span-24">
       <thead>
          <tr>
             <th class="span-4">Collection</th>
             <th class="span-2">Owner</th>
             <th class="span-2">Group</th>
             <th class="span-1">Decimal</th>
             <th class="span-1">Octal</th>
             <th class="span-2">String</th>
             <th class="span-1">Check</th>
          </tr>
        </thead>
       <tbody>{
         for $collection in $write-collections//collection/text()
         let $db-path := substring-after($collection, 'xmldb:exist://')
         let $group := xmldb:get-group($collection)
         let $perms := xmldb:get-permissions($collection)
         return
             <tr>
                <td>{ substring-after($collection, 'xmldb:exist:///db/cms/apps/') }</td>
                <td>{xmldb:get-owner($db-path)}</td>
                <td>{$group}</td>
                <td>{$perms}</td>
                <td>{local:int-to-oct( $perms )}</td>
                <td>{xmldb:permissions-to-string($perms)}</td>
                <td>{if ($group = 'cms-edit' and $perms = 508) then 'OK' else 'FAIL'}</td>
             </tr>
             
        }</tbody>
    </table>
</div>

return style:assemble-page($content)
    