xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $article := doc('/db/dma/apps/training/samples/04-nested-flowrs/article.xml')/article

let $title := $article/title/text()

return
<html>
   <head>
      <title>{$title}</title>
      <style><![CDATA[
         .section {margin-left: 10px;}
         .sub-section {margin-left: 30px;}
      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      {for $section in $article/section
      return
        <div class="section">
           <h2>{$section/title/text()}</h2>
           <p>{$section/para/text()}</p>
           {for $sub-section in $section/section
            return
              <div class="sub-section">
                 <h3>{$sub-section/title/text()}</h3>
                 <p>{$sub-section/para/text()}</p>
              </div>
            }
        </div>
      }
   </body>
</html>
