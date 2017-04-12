xquery version "1.0";

declare function local:sum-sequence($in as xs:integer*) as xs:integer {
  if (count($in) = 1)
    then $in
    else subsequence($in, 1, 1) + local:sum-sequence(subsequence($in, 2))
};


<results>
   <description>A sum of a sequence is the sum of all the numbers in a sequence.</description>
   <test> {local:sum-sequence((100, 3, 7))}</test>
   
   { for $i in (1 to 20)
       (: a sequence of integers :)
       let $seq := for $j in (1 to $i) return $j
       (: a sequence of strings :)
       let $seq-c := for $j in (1 to $i) return string($j)
       return
           <result>{string-join($seq-c, '+')} = {local:sum-sequence($seq)}</result>
   }
</results>




