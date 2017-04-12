xquery version "1.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $file-path := '/db/cust/northwestern/apps/tei/data/ham.xml'
let $doc := doc($file-path)
(: this says get all the speaker element, at any depth in the file :)
let $distinct-speakers := distinct-values($doc//speaker/text())

return
<html>
   <head>
      <title>Distinct Speakers</title>
    </head>
    <body>
       <h1>Listing of Distinct Speakers</h1>
       <p>TEI file {$file-path}</p>
       <ol>{
         for $speaker in $distinct-speakers
            order by $speaker
            return
              <li>{$speaker}</li>
      }</ol>
    </body>
</html>
