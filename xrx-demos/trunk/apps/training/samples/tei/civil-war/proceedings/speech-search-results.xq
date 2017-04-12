(: get sorted paginated extracts -
  :eg  speech-search-results-sorted.xq?start=30&keyword=slavery&order=location&direction=descending
:)

declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace vac = "http://richmond.edu/ns/secession" at "../modules/secession.xqm";

let $query := vac:get-url-query()
let $results := vac:speech-search-hits-properties($query)
let $results := vac:speech-search-hits-sorted($query)

return
   <result>
    {$query}
    {vac:speech-search-page($results,$query)}  
   </result>

