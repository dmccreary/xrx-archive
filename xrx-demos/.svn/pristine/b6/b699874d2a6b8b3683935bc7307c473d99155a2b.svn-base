
declare function local:remove-ssn($element as element()) as element() {
element {node-name($element)}
   {
   for $child in $element/node()[not(name(.)='ssn')]
      return
        if ($child instance of element())
           then local:remove-ssn($child)
           else $child
   }
};

let $path := '/db/dma/apps/training/samples/filters/file-with-ssn.xml'

let $doc := doc($path)/*

return
<results>
  {local:remove-ssn($doc)}
</results>
