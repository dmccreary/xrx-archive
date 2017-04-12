xquery version "1.0";

declare function local:diff($a, $b  as item()*  )  as item()* {
    if (empty($a) and empty ($b)) 
       then ()
       else
         if (empty ($b) or $a[1] lt $b[1])
            then
               (<div class="left">{$a[1]/text()}</div>,
                local:diff(subsequence($a, 2), $b)
               )
            else
              if (empty ($a) or $a[1] gt $b[1])
                  then
                    (<div class="right">{$b[1]/text()}</div>,
                     local:diff($a, subsequence($b,2))
                    )  
                  else
                     (<div class="match">{$a[1]/text()}</div>,
                      local:diff(subsequence($a,2), subsequence($b,2))
                     )
};
  
let $list1 := 
<list>
   <item>apples</item>
   <item>bananas</item>
   <item>carrots</item>
   <item>kiwi</item>
</list>
 
 
let $list2 := 
<list>
   <item>apples</item>
   <item>carrots</item>
   <item>grapes</item>
</list>
 

return 
<result>
   {local:diff($list1/item,$list2/item) }
</result>