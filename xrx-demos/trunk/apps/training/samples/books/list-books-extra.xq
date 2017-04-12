xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $title := 'Book List'

(: by default, we always sort by title :)
let $sort := request:get-parameter('sort', 'title')
let $format := request:get-parameter('format', '')

let $book-path := '/db/dma/apps/training/samples/books/books-sample.xml'

let $books := 
   if ($format)
      then doc($book-path)//book[format = $format]
      else doc($book-path)//book
      
let $sorted-books :=
    for $book in $books
        order by util:eval( concat('$book/', $sort, '[1]/text()') )
        return $book
        
return
<html>
   <head>
      <title>{$title}</title>
      <style type="text/css"><![CDATA[
         body {font-family: Arial,Helvetica,sans-serif;}
         table {border-collapse:collapse;}
         th {background-color: lavender;}
         tbody tr td, thead tr th {padding: 5px;}
         .even {background-color: khaki;}

      ]]></style>
   </head>
   <body>
      <h1>{$title}</h1>
      List of books at {$book-path} sorted by title.<br/>
      
      {if ($format) then <div>Format = {$format}</div> else  ()}
      
      Total Books = {count($books)}<br/>
      <table>
         <thead>
            <tr> 
               <th><a href="list-books-extra.xq?sort=title">Title</a></th>
               <th><a href="list-books-extra.xq?sort=author">Authors</a></th>
               <th><a href="list-books-extra.xq?sort=format">Format</a></th>
               <th><a href="list-books-extra.xq?sort=list-price">List Price</a></th>
            </tr>
         </thead>
         <tbody>
              {for $book at $count in $sorted-books
                 let $id := $book/id/text()
                 let $title := $book/title/text()
                 let $format := $book/format/text()
                 return
                    <tr>{if ($count mod 2)
                            then attribute class {'odd'}
                            else attribute class {'even'}}
                       <td><a href="view-book.xq?id={$id}">{$title}</a></td>
                       <td>{string-join($book/author/text(), ', ')}</td>
                       <td><a href="list-books-extra.xq?format={$format}">{$format}</a></td>
                       <td>{$book/list-price/text()}</td>
                    </tr>
              }
         </tbody>
      </table>
   </body>
</html>
