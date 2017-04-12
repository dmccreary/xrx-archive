declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace vac = "http://richmond.edu/ns/secession" at "../modules/secession.xqm";

let $startDate := request:get-parameter('startDate', '')
let $endDate := request:get-parameter('endDate', '')

return
    <data>
      {vac:master-events($startDate, $endDate)}
     </data>
