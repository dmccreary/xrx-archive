xquery version "1.0";

let $title := 'View Book'
let $id := request:get-parameter('id', '1')

return doc('/db/dma/apps/training/samples/books/books-sample.xml')//book[id = $id]