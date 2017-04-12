xquery version "1.0";
 
import module namespace xml-to-html = "http://danmccreary.com/xml-to-html" at "../modules/xml-to-html-module.xqm";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=no";

 
let $title := 'View XML as HTML'
 
let $input :=
<aaa a1="A1" a2="A2" a3="A3">
    <bbb b1="B1" b2="B2" b3="B3">BBB</bbb>
    <ccc c1="C1" c2="C2" c3="C3">
       <ddd d1="D1" d2="D2" d3="D3">DDD</ddd>
       <eee>
           <fff>this is <b a="a">123</b> complex <i>456</i> content.</fff>
       </eee>
    </ccc>
</aaa>
 
let $output := xml-to-html:dispatch($input, 1)
 
return
<html>
   <head>
      <title>{$title}</title>
      <link type="text/css" rel="stylesheet" href="../oxygen-theme.css"/>
   </head>
   <body>
      <div class="xml">
        {$output}
      </div>
   </body>
</html>

