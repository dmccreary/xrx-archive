xquery version "1.0";

(: copy the input to the output without modification :)
declare function local:copy($input as item()*) as item()* {
for $node in $input
   return 
      typeswitch($node)
        case element()
           return
              element {name($node)} {

                (: output each attribute in this element :)
                for $att in $node/@*
                   return
                      attribute {name($att)} {$att}
                ,
                (: output all the sub-elements of this element recursively :)
                for $child in $node
                   return local:copy($child/node())

              }
        (: otherwise pass it through.  Used for text(), comments, and PIs :)
        default return $node
};


let $in :=
<root>
   <a a1="11" a2="22">AAA</a>
   <b>BBB</b>
   <c>CCC<d a3="33" a4="44">D</d>CCC<e>EEE</e></c>
</root>

return local:copy($in)

