xquery version "1.0";
let $path := '/db/dma/apps/training/samples/xquery-updates/spreadsheet.xml'
let $doc := doc($path)/spreadsheet

return
<results>
   <updating-file>{$path}</updating-file>
{
for $item in $doc//row[not(first-name)]
  let $update := update rename $item/cell[1] as 'first-name'
  return
     <message>cell[1] of item {$item/id/text()} has been renamed to 'first-name'</message>
}</results>