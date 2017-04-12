xquery version "1.0";

module namespace security = "http://danmccreary.com/security";

(: collection, we will set the group of all the collections and resources to be "editor"
   as well as the permissions to be 770
   note that this is recursive :)
declare function security:set-perms($collection as xs:string) {
    (   xmldb:set-collection-permissions($collection, 'admin', 'cms-edit', util:base-to-integer(0770, 8) )
        ,
    
        for $sub-collection in xmldb:get-child-collections($collection)
          return
             security:set-perm-resource($collection, $resource)
       ,
       for $resource in xmldb:get-child-resources($collection)
          let $path := concat($collection, '/', $resource)
          return
             security:set-perm-resource($collection, $resource)
    )
};

declare function security:show-perms($collection as xs:string) {
<collection uri="{$collection}" group="{xmldb:get-group($collection)}" perms="{xmldb:permissions-to-string(xmldb:get-permissions($collection))}">
   {(
    for $resource in xmldb:get-child-resources($collection)
      order by $resource
      return
         <resource uri="{$resource}" group="{xmldb:get-group($collection, $resource)}" 
         perms="{xmldb:permissions-to-string(xmldb:get-permissions($collection, $resource))}"/>
   ,
   for $sub-collection in xmldb:get-child-collections($collection)
      return
         security:show-perms(concat($collection, '/', $sub-collection))
    )}
</collection>
};

(:
xmldb:set-resource-permissions($collection-uri as xs:string, 
$resource as xs:string, 
$user-id as xs:string, 
$group-id as xs:string, $permissions as xs:integer)
:)
declare function security:set-perm-resource($collection as xs:string, $resource as xs:string) {
  xmldb:set-resource-permissions($collection, $resource, 'admin', 'editor', 504)
};