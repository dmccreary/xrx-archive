declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace vac = "http://richmond.edu/ns/secession" at "../modules/secession.xqm";

let $query := vac:get-url-query()
let $results := vac:speech-search-hits-properties($query) 
return
 <result hits="{count($results/hit)}">
   {$query}
   {vac:delegate-analysis($results)}
   {vac:date-analysis($results)}
   {vac:location-analysis($results)}
 </result>
  
  
