xquery version "1.0";

module namespace app-info = "http://www.danmccreary.com/app-info";

(: put this line in your file to import these funtions:

import module template = "http://www.nuemeta.com/template" at "../../../modules/template.xqm";

:)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xrx="http://code.google.com/p/xrx";

(: we are going to hard code this path so we don't want to import the style module.  This avoids import loops.  :)

declare variable $app-info:site-home := '/db/dma';
declare variable $app-info:apps := concat($app-info:site-home, '/apps');

declare function app-info:app-home($app-id as xs:string) {
   concat($app-info:apps, '/', $app-id)
};

(: put this in your list-items and search results queries to display the prev and next links
   template:prev-next-controls($start, $num, $count, $category)
:)
declare function app-info:prev-next-controls($start as xs:integer, $num as xs:integer, $count as xs:integer, $category as xs:string) as node()* {

    let $category-param :=
       if ($category)
       then concat('&amp;category=', $category)
       else ()

    let $prev := if ($start gt $num)
      then <a href="list-items.xq?start={$start - $num}&amp;num={$num}{$category-param}">Previous</a>
      else ()
    
    let $next := if (($start + $num) lt $count)
       then <a href="list-items.xq?start={$start + $num}&amp;num={$num}{$category-param}">Next</a>
       else ()
       
    return ($prev, $next)
 };
 
 declare function app-info:category-buttons($cols as xs:integer) as node()* {
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
 
 