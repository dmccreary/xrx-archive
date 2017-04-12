xquery version "1.0";

import module namespace style = "http://nuemeta.com/style" at "../../../modules/style.xqm";

let $data-collection := $style:db-path-to-app-data

let $content :=
<div class="content">

<table>
{
         for $child in xdb:get-child-resources($data-collection)
         order by $child
         return
           <tr><td>{$child}</td></tr>
}
</table>
</div>
