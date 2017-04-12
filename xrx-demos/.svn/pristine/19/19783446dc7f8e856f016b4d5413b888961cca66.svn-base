xquery version "1.0";

(: A listing of the last access attempts.  Logins, logouts etc. :)

import module namespace style         = 'http://danmccreary.com/style'         at '../../../modules/style.xqm';

declare function local:collection-last-modified($collection as xs:string) as node()* {
<collection>
   {attribute {'cid'} {$collection} }
   {for $resource in xmldb:get-child-resources($collection)
      return
      <resource>
        {attribute {'cid'} {$collection}}
        {attribute {'id'} {$resource}}
        {attribute {'last-modified'} {xmldb:last-modified($collection, $resource)}}
      </resource>,
      if (exists(xmldb:get-child-collections($collection)))
        then (
           for $child in xmldb:get-child-collections($collection)
           order by $child
           return
              (: note the recursion here :)
              local:collection-last-modified(concat($collection, '/', $child))
           )
         else ()
  }
</collection>
};

let $title := 'Last Modified Files'
let $root-collection := '/db/chase/apps'

let $collections := local:collection-last-modified($root-collection)

let $resources := $collections//resource

let $sorted-resources :=
  for $resource in $resources
  order by xs:dateTime($resource/@last-modified) descending
  return $resource

let $content := 
<div>
    <p>List of last-modified files.</p>
    <table class="datatable span-17">
        <thead>
           <tr>
              <th class="row1 span-5">Collection</th>
              <th class="row1 span-4">File</th>
              <th class="row1 span-5 last">DateTime</th>
           </tr>
        </thead>
        <tbody>
    {for $resource at $count in $sorted-resources
       return
       <tr>
          {if ($count mod 2)
                    then attribute class {'odd'}
                    else attribute class {'even'}
          }
          <td>{substring-after($resource/@cid/string(), '/db/chase/')}</td>
          <td style="text-align:left;">{$resource/@id/string()}</td>
          <td style="text-align:left;">{$resource/@last-modified/string()}</td>
       </tr>
    }
       </tbody>
    </table>
</div>

return style:assemble-page($title, $content)