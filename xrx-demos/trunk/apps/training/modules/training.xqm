xquery version "1.0";

module namespace train = "http://www.danmccreary.com/training";

(: put this line in your file to import these funtions:

import module namespace train = "http://www.danmccreary.com/training" at "../../../modules/training.xqm";

:)

declare namespace request="http://exist-db.org/xquery/request";
declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace xrx="http://code.google.com/p/xrx";

(: we are going to hard code this path so we don't want to import the style module.  This avoids import loops.  :)
declare variable $train:app-home := '/db/dma/apps/training';
declare variable $train:class-data := concat($train:app-home, '/data/classes');
declare variable $train:topic-data := concat($train:app-home, '/data/topics');
declare variable $train:review-quiz-data := concat($train:app-home, '/data/review-quizes');
declare variable $train:lab-data := concat($train:app-home, '/data/labs');

(: returns a sequence strings of topic ids of topics a given class id :)
declare function train:topics-for-class($class-id as xs:string) as xs:string* {
  collection($train:class-data)/class[./id/text() = $class-id]//topic
};

(: returns a sequence nodes of lab for this class :)
declare function train:labs-for-class($class-id as xs:string) as node()* {
collection($train:lab-data)/lab[classes/id/text() = $class-id]
};

(: returns a sequence of string IDs lab-ids for this class :)
declare function train:labs-ids-for-class($class-id as xs:string) as xs:string* {
for $lab in collection($train:lab-data)/lab[classes/id/text() = $class-id]
return
   $lab/id/text()
};

(: returns a sequence of lab-ids for this class :)
declare function train:count-labs-for-class($class-id as xs:string?) as xs:integer? {
  count(collection($train:lab-data)/lab[classes/id/text() = $class-id])
};

(: returns a sequence of lab-ids for this class :)
declare function train:review-quiz($review-quiz-id as xs:string?) as node() {
let $topic := collection($train:review-quiz-data)//review-quiz[./id/text() = $review-quiz-id]
return
  if (exists($topic))
  then $topic
  else
    <error>
       <message>No review quiz found for review-quiz-id = {$review-quiz-id}</message>
    </error>
};

(: returns a sequence of lab-ids for this class :)
declare function train:topic($topic-id as xs:string) as node()* {
let $topic := collection($train:topic-data)//topic[./id/text() = $topic-id]
return
  if (exists($topic))
  then $topic
  else
    <error>
       <message>No topic found for topic-id = {$topic-id}</message>
    </error>
};

(: put this in your list-items and search results queries to display the prev and next links
   template:prev-next-controls($start, $num, $count, $category)
:)
declare function train:prev-next-controls($start as xs:integer, $num as xs:integer, $count as xs:integer, $category as xs:string) as node()* {

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
 
 declare function train:category-buttons($cols as xs:integer) as node()* {
    let $file-path := concat($train:app-home, '/code-tables/message-classification-codes.xml')
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
 
 declare function train:document-type-label($value as xs:string?) as xs:string {
    let $file-path := concat($train:app-home, '/code-tables/document-type-codes.xml')
    let $code-table-items := doc($file-path)//item
    let $label := $code-table-items[./value/text() = $value]/label/text()
   return
      if ($label)
         then $label
         else concat('No Label Found for value = ', $value, ' in file ', $file-path)
 };
 
  declare function train:level-label($value as xs:string) as xs:string {
    let $file-path := concat($train:app-home, '/code-tables/training-level-codes.xml')
    let $code-table-items := doc($file-path)//item
    let $label := $code-table-items[./value/text() = $value]/label/text()
   return
      if ($label)
         then $label
         else concat('No Label Found for value = ', $value, ' in file ', $file-path)
 };
 