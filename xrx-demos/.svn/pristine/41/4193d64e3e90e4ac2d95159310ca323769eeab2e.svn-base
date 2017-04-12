xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";


let $title := 'View Book'
let $id := request:get-parameter('id', '2')

return
(: check for required parameters :)
    if (not($id)) then 
        <error>
            <message>Parameter "id" is missing.  Please include this parameter.</message>
        </error>
    else
    
let $book := doc('/db/dma/apps/training/samples/books/books-sample.xml')//book[id = $id]

return
<html>
   <head>
     <title>{$title}</title>
   </head>
   <body>

       <div>
           id = {$book/id/text()}<br/>
           Title = {$book/title/text()}<br/>
           Authors = {string-join($book/author/text(), ', ')}<br/>
           Description = {string-join($book/description/text(), ', ')}<br/>
           Format = {string-join($book/format/text(), ', ')}<br/>
           Publish Date = {string-join($book/publish-date/text(), ', ')}<br/>
           License = {string-join($book/license/text(), ', ')}<br/>
           List Price = {string-join($book/list-price/text(), ', ')}<br/>
       </div>
       <a href="view-book-xml.xq?id={$id}">View XML</a>
    </body>
</html>
