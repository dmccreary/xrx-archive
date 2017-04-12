xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Book List'

let $book-path := '/db/dma/apps/training/samples/books/books-sample.xml'
let $books := doc($book-path)//book

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
      List of books at {$book-path} sorted by title.<br/>
      Total Books = {count($books)}<br/>
      <table>
         <thead>
            <tr>
               <th>Title</th>
               <th>Authors</th>
               <th>Format</th>
               <th>List Price</th>
            </tr>
         </thead>
         <tbody>
              {for $book in $books
                 let $id := $book/id/text()
                 let $title := $book/title/text()
                 order by $title
                 return
                    <tr>
                       <td><a href="view-book.xq?id={$id}">{$title}</a></td>
                       <td>{string-join($book/author/text(), ', ')}</td>
                       <td>{$book/format/text()}</td>
                       <td>{$book/list-price/text()}</td>
                    </tr>
              }
         </tbody>
      </table>
   </body>
</html>
