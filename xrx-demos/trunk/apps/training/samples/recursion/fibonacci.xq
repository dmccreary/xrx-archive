declare function local:fib-r($n as xs:integer, $m1 as xs:integer, $m2 as xs:integer) as xs:integer {
    if ($n = 1)
       then $m2
       else local:fib-r($n - 1, $m2, $m1 + $m2)
};

(: this is the front-function to get the recursion started :)
declare function local:fib($n as xs:integer) as xs:integer? {
   if ($n < 0) then ()
      else if ($n = 0) then 0
      else  local:fib-r($n, 0, 1)
};

<results>
   <description>In a Fibonacci sequence after the first two numbers the number is the sum of the prior two numbers.</description>
   { for $i in (0 to 20)
       return
           <result>fibonacci({$i}) = {local:fib($i)}</result>
   }
</results>




