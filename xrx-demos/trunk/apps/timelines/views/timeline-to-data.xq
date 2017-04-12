xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Timeline to Simile data format'

let $timeline-id := request:get-parameter('timeline-id', '')

let $events := collection('/db/dma/apps/timelines/data')/timeline[id/text() = $timeline-id]//event

return
<data date-time-format="iso8601">
  <timeline-id>{$timeline-id}</timeline-id>
  <count>{count($events)}</count>
  {for $event in $events
     return
        <event start="{$event/start-date/text()}" end="{$event/end-date/text()}" is-duration="true"/>
  }
</data>
