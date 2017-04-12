xquery version "1.0";
module namespace h = "http://danmccreary.com/help-manager";

(: the URI of the application :)
declare function h:app-db-path() as xs:string {
  '/db/dma/apps/help-manager'
};

declare function h:category-items() as node() {

let $code-tables := doc(concat(h:app-db-path(), "/code-tables/category-codes.xml"))

    return $code-tables
};