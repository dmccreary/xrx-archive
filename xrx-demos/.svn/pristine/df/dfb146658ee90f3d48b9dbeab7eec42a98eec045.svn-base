xquery version "1.0";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $data-collection := '/db/crossflo/apps/shop/data'

let $data := request:get-data()

let $file := $data//filename/text()

let $login := xmldb:login($data-collection, 'admin', 'admin123')

let $update := xmldb:store($data-collection, $file, $data)

return
<results>
  <message>Your file {$file} has been saved in collection {$data-collection}</message>
</results>
