xquery version "1.0";

let $book-path := '/db/dma/apps/training/samples/validation/books-sample.xml'
let $doc := doc($book-path)/books

let $clear := validation:clear-grammar-cache()
let $validation := validation:validate($doc)
let $validation-report := validation:validate-report($doc)

return
<results>
  <validation>{$validation}</validation>
  <validation-report>{$validation-report}</validation-report>
</results>