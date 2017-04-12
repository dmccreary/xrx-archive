xquery version "1.0";
let $path := '/db/dma/apps/training/samples/xquery-updates/spreadsheet.xml'
let $doc := doc($path)/spreadsheet

return
<results>
   <updating-file>{$path}</updating-file>
{
for $item at $counter in $doc//row[not(id)]
  let $update := update insert <id>{$counter}</id> preceding $item/cell[1]
  return
     <message>id added for row = {$counter}</message>
}</results>