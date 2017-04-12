declare function local:assemble-page($title as xs:string*, $content as node()) as node() {
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
          {local:header()}
          {$content}
          {local:footer()}
        </body>
     </html>
};

declare function local:header() as node() {
   <div id="header">Page Header</div>
};

declare function local:footer() as node() {
   <div id="footer">Page Footer</div>
};

let $title := 'Page Title'
let $content :=
<div class="content">
   <p>Hello World</p>
</div>

return local:assemble-page($title, $content)