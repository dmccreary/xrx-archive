xquery version "1.0";

declare function local:count-collection($collection as xs:string) as node() {
let $child-collections := xmldb:get-child-collections($collection)
return
  if (empty($child-collections))
     then
         <result>
              <files>{ count(xmldb:get-child-resources($collection)) }</files>
              <collection>1</collection>
          </result>
     else
        sum(
            for $child in $child-collections
            return
               local:count-files-in-collection(concat($collection, '/', $child))
               )
};

<return>
    <total-child-collections>{local:count-files-in-collection('/db')}</total-child-collections>
</return>
