xquery version "1.0";

(: Search for terms that start wtih a given prefix :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

let $data-collection := $style:db-path-to-app-data
let $prefix := request:get-parameter('prefix', '')
let $lower-case-prefix := lower-case($prefix)

(: create a sequence of terms that match the prefix :)
let $terms := collection($data-collection)//term[starts-with(id/text(), $lower-case-prefix)]

return
<results>
 <prefix>{$prefix}</prefix>{
  if ($prefix)
     then
    <items>{
      for $term in $terms
          order by $term/id/text()
          return
             $term/id
     }</items>
    else
    <error><message>prefix is a required parameter.  Try: starts-with.xq?prefix=a</message></error>
}</results>