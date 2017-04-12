xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $id := request:get-parameter('id', '1')

return
(: check for required parameters :)
    if (not($id)) then 
        <error>
            <message>Parameter "id" is missing.  Please include this parameter.</message>
        </error>
    else


let $book-path := '/db/dma/apps/training/samples/books/books-sample.xml'
return doc($book-path)//book[./id/text() = $id]