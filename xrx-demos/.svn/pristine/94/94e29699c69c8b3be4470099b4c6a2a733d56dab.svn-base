

declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace vac = "http://richmond.edu/ns/secession" at "../modules/secession.xqm";

let $id := request:get-parameter('id', ())
let $query := vac:get-url-query()
let $startPage :=collection($vac:data)//tei:pb[@xml:id=$id] 
return 
  <result>
   {$query}
   {vac:page($startPage,$query)}
 </result>