xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
import module namespace util2='http://danmccreary.com/util2' at '../../../modules/util2.xqm';
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Simile Timeline Viewer'

let $id := request:get-parameter('id', '')

let $data-collection := $style:db-path-to-app-data

let $timeline := collection($data-collection)//timeline[id/text() = $id]

(: create a sequence of start dates :)
let $start-dates := $timeline//start-date/text()

let $start-date-count := count($start-dates)

let $sorted-start-dates :=
  for $date in $start-dates
  order by $date
  return $date

let $midpoint-date := $sorted-start-dates[$start-date-count idiv 2]
let $midpoint-year := substring($midpoint-date, 1, 4)
let $month-string := util2:month-number-to-string( xs:integer(substring($midpoint-date, 6, 2)))

let $content :=
<div class="content">
   <script src="http://static.simile.mit.edu/timeline/api-2.3.0/timeline-api.js?bundle=true" type="text/javascript"></script>

    <script  type="text/javascript">

var tl;
 
 
function onLoad() {{
   var eventSource = new Timeline.DefaultEventSource();
   var bandInfos = [
     Timeline.createBandInfo({{
         eventSource:    eventSource,
         date:           "{$month-string} 01 {$midpoint-year} 00:00:00 GMT",
         width:          "70%", 
         intervalUnit:   Timeline.DateTime.MONTH, 
         intervalPixels: 100
     }}),
     Timeline.createBandInfo({{
         overview:       true,
         eventSource:    eventSource,
         date:           "{$month-string} 01 {$midpoint-year} 00:00:00 GMT",
         width:          "30%", 
         intervalUnit:   Timeline.DateTime.YEAR, 
         intervalPixels: 200
     }})
   ];
   bandInfos[1].syncWith = 0;
   bandInfos[1].highlight = true;
 
   tl = Timeline.create(document.getElementById("my-timeline"), bandInfos);
   Timeline.loadXML("timeline-to-data.xq?id={$id}", function(xml, url) {{ eventSource.loadXML(xml, url); }});
 }};
 
 var resizeTimerID = null;
 
 function onResize() {{
     if (resizeTimerID == null) {{
         resizeTimerID = window.setTimeout(function() {{
             resizeTimerID = null;
             tl.layout();
         }}, 500);
     }}
 }};

        </script>  

    <div onload="onLoad();" onresize="onResize();">

        <div id="my-timeline" style="height: 300px; border: 1px solid blue">
 
        </div>
        <noscript>
            This page uses Javascript to show you a Timeline. Please enable Javascript in your browser to see the full page. Thank you.
        </noscript>
        Midpoint date = {$midpoint-date}
   </div>
</div>

return
<html>
    <head>
        <title>{$title}</title>
       
         { style:css('xhtml') }
        <script src="http://static.simile.mit.edu/timeline/api-2.3.0/timeline-api.js?bundle=true" type="text/javascript"></script>
        <script  type="text/javascript" src="../unit-tests/simile-timeline-example2.js"></script>
    </head>
    <body onload="onLoad();" onresize="onResize();">
    <div class="container">
       { style:header() }
       
       { style:breadcrumbs(()) }
       {$content}
       
       { style:footer() }
       </div>
    </body>
</html>