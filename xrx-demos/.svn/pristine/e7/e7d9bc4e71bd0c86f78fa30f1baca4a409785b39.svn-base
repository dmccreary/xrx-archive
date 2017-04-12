xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title :='Book Metrics'
let $data-collection := '/db/dma/apps/books/data'
let $books := collection($data-collection)//book
let $total-books := count($books)
let $book-formats := distinct-values($books//format/text())

return
<html>
   <head>
      <title>{$title}</title>
      <style type="text/css"><![CDATA[
         body {font-family: Arial,Helvetica,sans-serif;}
         table {border-collapse:collapse;}
         th {background-color: lavender;}
         tbody tr td, thead tr th {padding: 5px;}
      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      Counts of books in collection: '{$data-collection}'<br/>
      Count of formats := {count($book-formats)}<br/>
      <table>
         <thead>
            <tr>
               <th>Metric</th>
               <th>Value</th>
            </tr>
         </thead>
         <tbody>
              <tr>
                 <th>Total Books</th>
                 <td>{count($books)}</td>
              </tr>
              {for $format in $book-formats  
                 order by $format
                 return
                    <tr>
                       <th>{$format} Books</th>
                       <td>{count($books[./format = $format])}</td>
                    </tr>
              }
         </tbody>
      </table>
   </body>
</html>