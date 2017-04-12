xquery version "1.0";

import module namespace docbook-to-html = "http://www.example.com/docbook-to-html" at  "docbook-to-html-typeswitch.xqm";

declare namespace docbook ="http://docbook.org/ns/docbook";
declare default element namespace "http://docbook.org/ns/docbook";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $input := doc('/db/dma/apps/training/samples/typeswitch/docbook-article.xml')/docbook:article

return
<html xmlns="http://www.w3.org/1999/xhtml">
       <head>
            <title>{$input/title/text()}</title>
       </head>
 <body>
         {docbook-to-html:main($input)}
  </body>
</html>
