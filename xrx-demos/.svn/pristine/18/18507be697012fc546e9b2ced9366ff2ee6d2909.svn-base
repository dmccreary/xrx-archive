xquery version "1.0";
module namespace u = "http://danmccreary.com/faq";

(: the URI of the application :)
declare function u:app-db-path() as xs:string {
  '/db/dma/apps/faq'
};

declare function u:category-labels($category as xs:string) as xs:string* {
let $category := doc(concat(u:app-db-path(), '/data/', $category, '.xml'))
let $code-tables := doc(concat(u:app-db-path(), "/code-tables/faq-category-codes.xml"))

let $sequence :=
  for $value in $category/faq-category-id/text()
    let $label := $code-tables//item[./value/text() = $value]/label/text()
    return $label
    
    return $sequence
};