xquery version "1.0";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";
 
let $collection := request:get-parameter('collection', '/db/dma/apps/shop/data')
 
return
<files>{
         for $child in xdb:get-child-resources($collection)
         order by lower-case($child)
         return
        <file>{$child}</file>
}</files>

