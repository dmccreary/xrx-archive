xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

import module namespace gc = 'http://www.danmccreary.com/google-charts' at 'google-charts-module.xqm';

let $height := 20
let $width := 300

(: these are currently percentages :)
let $danger := 50
let $warn := 75
let $ok := 100
let $target := 85
let $actual := 65

return
<html>
  <head>
    <title>Test Driver for Google Bullet Bar</title>
     <style type="text/css"><![CDATA[
        body {font-family: arial, helvetica, sans-serif;}
        .blue-border {border: solid blue 1px;}
        ]]></style>
  </head>
    <body>
    <div class="blue-border">
      <img src="{gc:bullet-bar($height, $width, $danger, $warn, $ok, $target, $actual)}"/>
      <a href="{gc:bullet-bar($height, $width, $danger, $warn, $ok, $target, $actual)}">gc:bullet-bar($height, $width, $danger, $warn,  $ok, $target, $actual)</a>
      </div>
    </body>
</html>