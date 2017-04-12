xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $page :=
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
        <script src="http://static.simile.mit.edu/timeline/api-2.3.0/timeline-api.js?bundle=true" type="text/javascript"></script>
        
        <script type="text/javascript" src="simile-timeline-example2.js"></script>
    </head>
    <body onload="onLoad();" onresize="onResize();">
        <h1>Timeline test version 2 - Using JavaScript src reference.</h1>
        <div id="my-timeline" style="height: 150px; border: 1px solid #aaa"></div>
        <noscript>
            This page uses Javascript to show you a Timeline. Please enable Javascript in your browser to see the full page. Thank you.
        </noscript>
    </body>
</html>

return $page