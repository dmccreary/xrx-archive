xquery version "1.0";
let $path := '/db/dma/apps/training/samples/xquery-updates/spreadsheet.xml'
let $doc := doc($path)/spreadsheet

return
<results>
   <updating-file>{$path}</updating-file>
{
for $item in $doc//row[not(created-by)]
  let $cr-lm :=
  (<created-by>{xmldb:get-current-user()}</created-by>,
   <created-datetime>{current-dateTime()}</created-datetime>,
   <last-modified-by>{xmldb:get-current-user()}</last-modified-by>,
   <last-modified-datetime>{current-dateTime()}</last-modified-datetime>
)
  let $update := update insert $cr-lm into $item
  return
     <message>item {$item/id/text()} has cr-lm data added.</message>
}</results>