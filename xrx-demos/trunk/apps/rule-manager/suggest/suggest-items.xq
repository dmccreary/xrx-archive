xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


(: suggest-items.xq - used to populate an XForms suggest-items instance :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $doc-name := 'jiem-conditions.xml'
let $doc := concat($data-collection, '/', $doc-name)
let $title :='Search Suggest'

let $prefix := xs:string(request:get-parameter('prefix', ''))

let $lc-prefix := lower-case($prefix)

let $content :=
<div class="content">

if (string-length($prefix) > 0)
   then(
<suggestions>
{
    for $item in doc($doc)/conditions/condition[starts-with(@predicate, $lc-prefix)]
       let $predicate := string($item/@predicate)
       order by $predicate
    return
      <item>{$predicate}</item>
}</suggestions>)
   else (<suggestions/>)
   
</div>

return style:assemble-page($title, $content)