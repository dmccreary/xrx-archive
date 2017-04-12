xquery version "1.0";

declare function local:factorial($n as xs:integer) as xs:integer {
   if ($n < 0)
      then 0
      else
          if ($n = 0)
             then 1
             else ($n * local:factorial($n - 1))
};

<results>
   <description>A factorial is the product all the numbers from one to this number.</description>
   { for $i in (1 to 20)
       return
           <result>factorial({$i}) = {local:factorial($i)}</result>
   }
</results>




