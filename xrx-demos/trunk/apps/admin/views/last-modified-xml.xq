xquery version "1.0";

(: A listing of the last access attempts.  Logins, logouts etc. :)


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

let $root-collection := '/db/chase/apps'

let $collections := local:collection-last-modified($root-collection)
let $resources := $collections//resource
let $sorted-resources :=
  for $resource in $resources
  order by xs:dateTime($resource/@last-modified) descending
  return $resource

return
<results>
 <description>List of resources sorted with most recently modified at the top of the list.</description>
 {$sorted-resources}
</results>
