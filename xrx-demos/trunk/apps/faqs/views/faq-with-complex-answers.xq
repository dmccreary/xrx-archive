xquery version "1.0";

declare option exist:serialize "method=html media-type=text/html indent=yes";

let $collection := '/db/apps/faqs/data'
return
<html>
   <head>
      <title>List FAQs</title>
      <style language="text/css">
          <![CDATA[
            body {font-family: Arial, Helvetica; sans-serif;}
           ]]>
      </style>
   </head>
   <body>
   <a href="../index.xhtml">FAQ Home</a>
   <ol>
   {
      for $item in collection($collection)/faq[answer/./*]
         let $id := $item/id/text()
      return
        <li>#{$id} - {$item/question/text()}<a href="../edit/edit.xq?id={$id}">Edit</a></li>
    }
    </ol>
   </body>
</html>
