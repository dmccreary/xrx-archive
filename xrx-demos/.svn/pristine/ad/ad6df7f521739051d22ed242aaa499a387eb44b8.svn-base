xquery version "1.0";
 
declare function local:chmod-collection($collection) {
   xmldb:chmod-collection($collection,508),
   for $child in xmldb:get-child-collections($collection)
   return
       local:chmod-collection(concat($collection, "/", $child))
};

(:
   guest-none=504
   guest-read=508
   guest-read-write=510
   guest-all=511
:)
system:as-user('admin', 'admin123', (
   local:chmod-collection("/db/dma"),
   for $doc in collection("/db/dma")
   return
       xmldb:chmod-resource(
         util:collection-name($doc),
         util:document-name($doc),
         508
      )
   )
)

