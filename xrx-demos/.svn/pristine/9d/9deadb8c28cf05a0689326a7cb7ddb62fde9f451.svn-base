xquery version "1.0";
let $options := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')

let $files :=
   for $file in xmldb:get-child-resources('/db/xforms/test')
   return
      if (ends-with($file, 'xml'))
        then $file
        else ()

return
<html>
    <head>
        <title>XSLTForms: XForms for browsers without plug-in</title>
    </head>
    <body>
        <p>Examples from supplied by XSLTForms:</p>
        {for $file in $files
         return
            <li>
                <a href="render-form.xq?file={$file}">{$file}</a>
            </li>
         }
       
    </body>
</html>

