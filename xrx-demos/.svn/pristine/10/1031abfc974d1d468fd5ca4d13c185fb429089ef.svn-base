xquery version "1.0";
import module namespace style='http://mdr.crossflow.com/style' at '/db/crossflo/modules/style.xq';
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

(: suggest-items.xq - used to populate an XForms suggest-items instance :)

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-name := 'jiem-conditions.xml'
let $doc := concat($data-collection, '/', $doc-name)

let $prefix := xs:string(request:get-parameter('prefix', ''))

let $lc-prefix := lower-case($prefix)

return
if (string-length($prefix) > 0)
   then(
<suggestions>
{
    for $item in doc($doc)/conditions/condition[starts-with(@predicate,  $lc-prefix)]
       let $predicate := string($item/@predicate)
       order by $predicate
    return
      <item>{$predicate}</item>
}</suggestions>)
   else (<suggestions/>)