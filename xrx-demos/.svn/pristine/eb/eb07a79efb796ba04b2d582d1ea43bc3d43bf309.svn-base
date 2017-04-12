xquery version "1.0";

module namespace style = "http://example.com/style";

declare function style:assemble-page($title as xs:string*, $content as node()) as node() {
let $set-xhmtl-serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')
return
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>{$title}</title>
            <link rel="shortcut icon" type="image/x-icon" href="xquery.png"/>
            <style type="text/css"><![CDATA[
               #footer, #header {background-color: lavender;}
            ]]></style>
        </head>
        <body>
          {style:header()}
          {$content}
          {style:footer()}
        </body>
     </html>
};

declare function style:header() as node() {
   <div id="header">Page Header</div>
};

declare function style:footer() as node() {
   <div id="footer">Page Footer</div>
};
