xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $page :=
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
        <script src="http://static.simile.mit.edu/timeline/api-2.3.0/timeline-api.js?bundle=true" type="text/javascript"></script>
        <script type="text/javascript"><![CDATA[
            var tl;
            function onLoad() {
            var eventSource = new Timeline.DefaultEventSource();
            var bandInfos = [
              Timeline.createBandInfo({
                  eventSource:    eventSource,
                  date:           "Mar 28 2011 00:00:00 GMT",
                  width:          "70%", 
                  intervalUnit:   Timeline.DateTime.MONTH, 
                  intervalPixels: 100
              }),
              Timeline.createBandInfo({
                  overview:       true,
                  eventSource:    eventSource,
                  date:           "Mar 28 2011 00:00:00 GMT",
                  width:          "30%", 
                  intervalUnit:   Timeline.DateTime.YEAR, 
                  intervalPixels: 200
              })
            ];
            bandInfos[1].syncWith = 0;
            bandInfos[1].highlight = true;
            
            tl = Timeline.create(document.getElementById("my-timeline"), bandInfos);
            Timeline.loadXML("example1.xml", function(xml, url) { eventSource.loadXML(xml, url); });
          };
           
            var resizeTimerID = null;
            
            function onResize() {
                if (resizeTimerID == null) {
                    resizeTimerID = window.setTimeout(function() {
                        resizeTimerID = null;
                        tl.layout();
                    }, 500);
                }
            };
              
        ]]></script>
    </head>
    <body onload="onLoad();" onresize="onResize();">
        <h1>Timeline test version 1</h1>
        <div id="my-timeline" style="height: 150px; border: 1px solid #aaa"></div>
        <noscript>
            This page uses Javascript to show you a Timeline. Please enable Javascript in your browser to see the full page. Thank you.
        </noscript>
    </body>
</html>

return $page