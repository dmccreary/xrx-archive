xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";

import module namespace de = "http://mdr.crossflow.com/data-elements" at "/db/crossflo/apps/data-elements/modules/data-elements.xqm";

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";

<html>
   <head>
      <title>Test Driver for Data Elements Module</title>
      {style:import-css()}
    </head>
    <body>
       {style:header()}
       {style:breadcrumb()}
       <h1>Test Driver for Data Elements Module</h1>
       <get-definition-for-element>
       {de:niem-element-names()}
       </get-definition-for-element>
    </body>
</html>