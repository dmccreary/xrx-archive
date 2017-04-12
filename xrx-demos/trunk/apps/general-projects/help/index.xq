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
       <h1>Information Sharing Projects Help File</h1>
       <p>
        The information sharing project manager can assist you at the creation and maintence of the entire
        lifecycle of an information sharing project including:
        </p>
       <ol>
          <li>Requirments</li>
          <li>Design</li>
          <li>Development</li>
          <li>Testing</li>
          <li>Maintenance</li>
          <li>Status Reporting</li>
       </ol>
       
       <h2>Navigation</h2>
       <p>You can use the breadcrumbs to navigate to any level of the application or go directly
       into other applications.  Please remember to save your forms before you navigate away
       from any screen.</p>
       
       {style:footer()}
    </body>
</html>