xquery version "1.0";

declare function local:count-collections($collection as xs:string) as xs:integer {
let $child-collections := xmldb:get-child-collections($collection)
return
  if (empty($child-collections))
     then 1
     else
        sum(
            for $child in $child-collections
            return
               local:count-collections(concat($collection, '/', $child))
               )
};

<test-group>
    <test>
      <count-collections>/db/dma/apps/training/samples={local:count-collections('/db/dma/apps/training/samples')}</count-collections>
    </test>
    <test>
      <count-collections>/db/dma/apps/training={local:count-collections('/db/dma/apps/training')}</count-collections>
    </test>
    <test>
      <count-collections>/db={local:count-collections('/db')}</count-collections>
    </test>
</test-group>
