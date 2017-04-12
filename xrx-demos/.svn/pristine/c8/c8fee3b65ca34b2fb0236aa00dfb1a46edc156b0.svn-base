xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $page := 
<html>
    <head>
        <title>AnyChart Sample</title>
        <script type="text/javascript" language="javascript" src="../../../resources/js/anychart/js/AnyChart.js"></script>
    </head>
    <body>
    <p>Test of Chart Rendering</p>
        <script type="text/javascript" language="javascript"><![CDATA[
    var chart = new AnyChart('../../../resources/js/anychart/swf/AnyChart.swf');
    chart.width = 700;
    chart.height = 300;
    chart.setXMLFile('./01-hello-world.xml');
    chart.write();
]]>
    </script>
    
    
    </body>
</html>
return $page