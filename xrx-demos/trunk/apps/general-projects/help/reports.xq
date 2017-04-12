xquery version "1.0";
import module namespace style='http://mdr.crossflow.com/style' at '/db/crossflo/modules/style.xq';
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Information Sharing Projects Help File</title>
        {style:import-css()}
    </head>
    <body>
       {style:header()}
       {style:breadcrumb()}
       <h1>Information Sharing Projects Reports</h1>
       <p>
        The following reports can be run:
        </p>
       <ol>
          <li>List All Information Sharing Projects <a href="../views/list-items.xq">Click Here</a></li>
          <li>List All Your Information Sharing Projects <a href="../views/list-items.xq?options=self">Click Here</a></li>
          <li>Metrics <a href="../views/metrics">Click Here</a></li>

       </ol>
       
       
       {style:footer()}
    </body>
</html>