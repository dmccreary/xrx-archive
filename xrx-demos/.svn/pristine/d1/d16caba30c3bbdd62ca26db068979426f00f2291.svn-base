xquery version "1.0";

module namespace amk-train = "http://www.danmccreary.com/training";

declare function amk-train:header() as node() {
    <div class="web-page-header">
        <img src="images/mylogo.jpg" alt="Our Logo"/>
        <h1>Acme Widgets Inc.</h1>
    </div>
};

declare function amk-train:footer() as node() {
    <div class="web-page-footer">
        <img src="images/mylogo.jpg" alt="Our Logo"/>
        <p>Acme Widgets Inc.</p>
    </div>
};
 
declare function amk-train:assemble-page($title as xs:string, $content as node()) as node() {
<html>
   <head>
      <title>{$title}</title>
   </head>
   <body>
     {amk-train:header()}
     <div class="content">{$content}</div>
     {amk-train:footer()}
   </body>
</html>
};