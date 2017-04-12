xquery version "1.0";

declare namespace pmml="http://www.dmg.org/PMML-3_1";

(: open the file :)
let $pmml-doc := doc('/db/dma/apps/pmml/data/sepal.xml')/pmml:PMML

let $node-count := count($pmml-doc//node())

return
<results>
   Your file has {$node-count} nodes in it.
</results>
