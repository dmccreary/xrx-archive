xquery version "1.0";

module namespace email = "http://www.danmccreary.com/xrx/email";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xrx="http://code.google.com/p/xrx";

declare variable $email:app-home := '/db/org/ucsb/apps/email';

declare function email:prev-next-controls($start as xs:integer, $num as xs:integer, $count as xs:integer, $category as xs:string) as node()* {

    let $category-param :=
       if ($category)
       then concat('&amp;category=', $category)
       else ()

    let $prev := if ($start gt $num)
      then <a href="list-items.xq?start={$start - $num}&amp;num={$num}{$category-param}">Previous</a>
      else ()
    
    let $next := if (($start + $num) le $count)
       then <a href="list-items.xq?start={$start + $num}&amp;num={$num}{$category-param}">Next</a>
       else ()
       
    return ($prev, $next)
 };
 
 declare function email:category-buttons($cols as xs:integer) as node()* {
    let $file-path := concat($email:app-home, '/code-tables/message-classification-codes.xml')
    let $code-table := doc($file-path)
    return
    <div class="category-buttons">
       {for $item at $item-count in $code-table//item
          let $label := $item/label/text()
          let $value := $item/value/text()
          return
             (
                <a class="category-button" href="views/list-items.xq?category={$value}">{$label}</a>
             ,
             if (not($item-count mod $cols)) then (<br/>,<br/>) else ()
             )
    }</div>
 };
 
 