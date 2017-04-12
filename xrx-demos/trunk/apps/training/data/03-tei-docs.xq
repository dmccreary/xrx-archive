xquery version "1.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

let $plays := collection('/db/org/northwestern/apps/tei/data')/tei:TEI[descendant::tei:castList]

return
<results>
   {count($plays)}
</results>
