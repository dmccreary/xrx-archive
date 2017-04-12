declare function local:assemble-page($title as xs:string*, $content as node()) as node() {
let $set-xhmtl-serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')
return
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>{$title}</title>
        </head>
        <body>
          {$content}
        </body>
     </html>
};

let $title := 'Page Title'
let $content :=
<div class="content">
   <p>Hello World</p>
</div>

return local:assemble-page($title, $content)