xquery version "1.0";

(: double a single integer :)
declare function local:double-int($in as xs:integer) as xs:integer {
  $in * $in
};

declare function local:double-deq($in-seq as xs:integer*) as xs:integer* {
  for $item in $in-seq
     return local:double-int($item)
};

let $title := 'Passing Functions as Parameters'

return
<results>
   <test>
      <input>local:double-int(2)</input>
      <output>{local:double-int(2)}</output>
   </test>
</results>