xquery version "1.0";

let $timeline-id := request:get-parameter('timeline-id', '1')
let $date := xs:date(request:get-parameter('date', ''))

(: create a sequence of all events :)
let $events := collection('/db/dma/apps/timelines/data')/timeline[id/text() = $timeline-id]//event

let $events-during-date :=
   for $event in $events[
      xs:date(./start-date/text()) lt $date
      and xs:date(./end-date/text()) gt $date
      ]
    return $event
    
return
<results>
  <event-count>{count($events)}</event-count>
  {$events-during-date}
</results>
