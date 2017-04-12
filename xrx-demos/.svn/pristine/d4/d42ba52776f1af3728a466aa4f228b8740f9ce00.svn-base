xquery version "1.0";
module namespace u = "http://danmccreary.com/user-manager";

(: the URI of the application :)
declare function u:app-db-path() as xs:string {
  '/db/dma/apps/user-manager'
};

declare function u:role-labels($user as xs:string) as xs:string* {
let $user := doc(concat(u:app-db-path(), '/data/', $user, '.xml'))
let $code-tables := doc(concat(u:app-db-path(), "/code-tables/user-role-codes.xml"))

let $sequence :=
  for $value in $user//role/text()
    let $label := $code-tables//item[./value/text() = $value]/label/text()
    return $label
    
    return $sequence
};