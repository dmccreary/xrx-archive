xquery version "1.0";

(:~ Module: secession.xqm
This version  Feb 5 2011 with generic search/sort function
   vac:speech-search-hits-sorted
  
These replace previous speech search functions:
   vac:speech-search-hits-scored
   vac:speech-search-hits-no-ft
   
similarly the element search is  generic
    vac:element-search-hits-sorted
    
see the test script for examples of use of all functions

:)

module namespace  vac = "http://richmond.edu/ns/secession";
import module namespace kwic="http://exist-db.org/xquery/kwic";
import module namespace ft="http://exist-db.org/xquery/lucene";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $vac:data := '/db/civil-war/va-convention/proceedings/data/';
declare variable $vac:ref := '/db/civil-war/va-convention/proceedings/ref/';

(:
declare variable $vac:data := '/db/apps/richmond/data/';
declare variable $vac:ref := '/db/apps/richmond/ref/';
:)

declare variable $vac:delegates := doc(concat($vac:ref,'delegates.xml'))//delegate;
declare variable $vac:locations := doc(concat($vac:ref,'locations.xml'))//location;
declare variable $vac:index := doc(concat($vac:ref,'coll-index.xml'))//document;
declare variable $vac:events := doc(concat($vac:ref,'master-events.xml'));

declare variable $vac:kwic-config := <config xmlns="" width="200" table="no"/>;


(:~ construct query structure from various url parameters
  :@param element : The element name to be searched - default is sp
                                      any element in the document is supported eg. text ..
                                      Used by the generic element search function
  :@param keyword : the words or phrases to search for   - default null = no search on keyword
                                     multiple values are separated by a comma - these are treated as words to use in a near search
                                     CK  - some old code may use 'keywords' here but is not now supported
  :@param startDate : the startDate of a range of dates   - inclusive  - default null = first
  :@param endtDate : the endDate of a range of dates  - inclusive - default null = last
  :@param delegates : the delegates to select - these are key values e.g. 'amblerwm' - multiple values are comma-separated - default null = all delegates
  :@param locations : the locations to select - these are tgn values e.g.'2002170' - muliple values are comma-separated - default null = all locations
  :@param maxMatches : the number of matches on any hit to include in the result - default 5
  :@param start  :  the index of the first hit in the page to include - default 1
  :@param hitsPerPage  : the number of hits to include on a page  - default 10
  :@param order  : the field to use in the sorting of hits :  allowable values are :  date (ascending), score (descending), delegate (ascending), location (ascending)
  :@param direction : the direction of the sort : ascending or descending : the default depends on the order as described above
  :@return query  - an XML structure which is passed around to control the search and presentation
:)
declare function vac:get-url-query() as element(query){
let $element := request:get-parameter("element","sp")
let $keywords := tokenize(normalize-space(request:get-parameter('keyword', ())),",")
let $qstartDate :=  request:get-parameter("startDate",())
let $qendDate :=  request:get-parameter("endDate",())
let $qdelegates := tokenize(request:get-parameter("delegates",()),",")
let $qlocations := tokenize(request:get-parameter("locations",()),",")

return
<query>
   <element>{$element}</element>
   {if (exists($keywords))
    then 
      <ft>
         {if (count($keywords) =1)
          then 
             if (contains($keywords,"*"))
             then <wildcard>{$keywords}</wildcard>
             else if (contains($keywords," "))
             then <phrase>{$keywords}</phrase>
             else <term>{$keywords}</term>
          else 
            <near slop="{count($keywords) * 10}" ordered="no">
            {for $keyword in $keywords
             return 
               <term>{$keyword}</term>
            }
            </near>
          }
      </ft>
    else ()
   }
   {if ($qstartDate) then <startDate>{$qstartDate}</startDate> else ()}
   {if ($qendDate) then <endDate>{$qendDate}</endDate> else ()}
   {for $delegate in $qdelegates
    return <delegate>{$delegate}</delegate>
   }
   {for $location in $qlocations
    return <location>{$location}</location>
   }
   <maxMatches>{request:get-parameter("maxMatches",5)}</maxMatches>
   <start>{request:get-parameter("start",1)}</start>
   <hitsPerPage>{request:get-parameter("hitsPerPage",10)}</hitsPerPage>
   {
    if (exists(request:get-parameter("order",())))
    then
       (<order>{request:get-parameter("order",())}</order>,
        <direction>{request:get-parameter("direction",())}</direction>
       )
    else ()  
   }
</query>
};

(:~ perform a search of the speech (sp ) nodes and return the properties of each hit required for analysis or sorting

  :@param $query  - a query structure
  :@return  for each hit, the date, delegate and locations 
:)
declare function vac:speech-search-hits-properties($query as element(query)) as element(results) {
 <results>
       {
         let $hits := collection($vac:data)//tei:sp
         let $ft := $query/ft/node()
         let $hits := 
             if ($ft) 
             then $hits[ft:query(., $ft)]
             else $hits
         let $delegates := 
             ($query/delegate,
              for $location in $query/location
              return $vac:delegates[tgn=$location]/@key
             )
          let $hits := 
            if ($delegates)
            then $hits[tei:speaker/tei:persName/@key = $delegates]
            else $hits         
         for $hit in $hits
         let $date := $hit/preceding::tei:dateline[1]/tei:date
         let $speaker := $hit/tei:speaker/tei:persName          
         let $delegate := $vac:delegates[@key=$speaker/@key]  
         let $locations := $vac:locations[@tgn=$delegate/tgn]
         where 
             (empty ($query/startDate) or $date ge $query/startDate)
             and (empty($query/endDate) or  $date le $query/endDate)  
         return 
            <hit id="{$hit/@xml:id/string()}">
              <date n="{string($date/@n)}">{string($date/@when)}</date>
              <score>{ft:score($hit)}</score>
              {$delegate}
              {$locations}  
            </hit>
      }
</results>
};



declare function vac:speech-search-hits-sorted($query as element(query)) {
   let $delegates := 
             ($query/delegate,
              for $location in $query/location
              return $vac:delegates[tgn=$location]/@key
             )
             
   let $command := 
       concat('
          
         let $hits := collection($vac:data)//tei:sp',
         
         if ($query/ft/node()) 
         then '[ft:query(.,$query/ft/node())]'
         else () ,
         
         if ($delegates)
         then '[tei:speaker/tei:persName/@key = $delegates]'
         else () ,
         
         if ($query/startDate)
         then '[preceding::tei:dateline[1]/tei:date/@when/string() ge $query/startDate]'
         else () ,
         
         if ($query/endDate)
         then '[preceding::tei:dateline[1]/tei:date/@when/string() le $query/endDate]'
         else () ,

         if ($query/order)
         then concat (' for $hit in $hits order by ',
         if ($query/order="score") then 'ft:score($hit)'
         else if ($query/order="date") then '$hit/preceding::tei:dateline[1]/tei:date/@when/string() '
         else if ($query/order="delegate") then '$hit/tei:speaker/tei:persName/@key '
         else if ($query/order="location")
         then 
               'let $speaker := $hit/tei:speaker/tei:persName
                let $delegate := $vac:delegates[@key = $speaker/@key]
                return $vac:locations[@tgn = $delegate/tgn][1]/@name '
         else 'true()' ,
 
         vac:direction($query),
         ' return $hit' 
         )
         else 'return $hits '
        )
     return 
        if ($query/debug)
        then $command
        else util:catch("*",util:eval($command),<error>Compile error</error>)
};

(:
   generalized search on elements div1, div2 , div3 ?
   sortable by score and date

:)
declare function vac:element-search-hits-sorted($query as element(query))   {
     let $command := 
       concat('
          
         let $hits := collection($vac:data)//tei:body//tei:',
         
         $query/element,
         
         if ($query/ft/node()) 
         then '[ft:query(.,$query/ft/node())]'
         else () ,
         
         if ($query/startDate)
         then '[preceding::tei:dateline[1]/tei:date/@when/string() ge $query/startDate]'
         else () ,
         
         if ($query/endDate)
         then '[preceding::tei:dateline[1]/tei:date/@when/string() le $query/endDate]'
         else () ,

         if ($query/order)
         then concat (' for $hit in $hits order by ',
         if ($query/order="score") then 'ft:score($hit)'
         else if ($query/order="date") then '$hit/preceding::tei:dateline[1]/tei:date/@when/string() '
         else 'true()' ,
 
         vac:direction($query),
         ' return $hit' 
         )
         else 'return $hits '
        )
     return 
        if ($query/debug)
        then $command
        else util:catch("*",util:eval($command),<error>Compile error</error>)

};


(:~ extract a range of hits and augment with additional properties
   :@param $hits  a sequence of hits 
   :@param $query the query
   :      the elements used are:
   :         start - the first index of the first hit in the range 
   :         hitsPerPage - the number of hits on a Page
   :@return a sequence of hits augmented with 
   :      the xml:id of the hit 
   :      the date of the hit
   :      the Lucene score
   :      the speaker
   :      the delegate located in the delegate reference document
   :      the delegate locations from the locations reference document
   :      the containing volume
   :      the summarised parent elements of the hits (xml:id, head, dateline, speaker where present)  
   :      for each match in the hit
   :       the id of the page 
   :       the date 
   :       the text surrounding the hit
:)

declare function vac:speech-search-page($hits as node()*, $query as element(query)) as element(results) {
let $max := count($hits)
let $first := xs:integer($query/start)
let $last := min(($max,$first +  xs:integer($query/hitsPerPage) - 1))
return
<results max = "{$max}" first="{$first}" last="{$last}">
       {   for $hit in subsequence($hits, $first ,$last - $first + 1)
           let $hit-pb := $hit/preceding::tei:pb[1]/@xml:id 
           let $date := $hit/preceding::tei:dateline[1]/tei:date/@when
           let $n := $hit/preceding::tei:dateline[1]/tei:date/@n
           let $speaker := $hit/tei:speaker/tei:persName          
           let $delegate := $vac:delegates[@key=$speaker/@key]  
           let $locations := $vac:locations[@tgn=$delegate/tgn]
           return  
           <hit> 
              <id>{string($hit/@xml:id)}</id>
              <date n="{string($n)}">{string($date)}</date>
              <volume>{$hit/preceding::tei:title[@type="main"][1]}</volume>
              {if (ft:score($hit)) then <score>{ft:score($hit)}</score> else ()}
              {$speaker}
              {$delegate}
              {$locations}
              {vac:parents($hit)}
              {vac:extract($hit,$query)}
            </hit>
         }
</results>
};


(:~
 : ignore some text which is in added material when it appears in the kwic string 
 : here we ignore text in  tei:stage and tei:persName nodes 
 : function will be called by kwic:get-summary 
 :@param $text  - the string provided 
 :@parameter $direction - before or after the match
 :@return null for text to be ignored, otherwise the input string 
:)
declare function vac:ignore-annotation($text,$direction) {
  let $node := $text/..
  return
    typeswitch($node)
        case element(tei:stage) return ()
        case element(tei:note) return ()   
        default return $text 
};
declare variable $vac:ignore-annotation := util:function(xs:QName("vac:ignore-annotation"),2)  ;

declare function vac:extract($hit,$query) {
  if ($query/ft)
  then
   let $context := kwic:expand($hit)
   let $matches := $context//exist:match
   let $hit-pb := $hit/preceding::tei:pb[1]/@xml:id 
   for $match in subsequence($matches,1,$query/maxMatches)
   let $date := $hit/preceding::tei:dateline[1]/tei:date/@when
   let $match-pb := $match/preceding::tei:pb[1]/@xml:id
   return
      <match pbid="{($match-pb,$hit-pb)[1]}"  date="{$date}">  
         {kwic:get-summary($context, $match, $vac:kwic-config, $vac:ignore-annotation)}
      </match>  
  else 
     (: no full-text search - just get the first paragraph :)
     let $hit-pb := $hit/preceding::tei:pb[1]/@xml:id 
     let $date := $hit/preceding::tei:dateline[1]/tei:date/@when
     return
        <match pbid="{$hit-pb}" date="{$date}">
          {$hit/tei:p[1]}
        </match>
};

(:~  search all named elements in the corpus
  :)
declare function vac:element-search-hits-properties($query as element(query)) as element(results) {
<results>
       { let $exp := concat("collection($vac:data)//tei:body//tei:",$query/element,"[ft:query(., $query/ft/node())]") 
         for $hit in util:eval($exp) 
         let $date := $hit/preceding::tei:dateline[1]/tei:date
         return 
           <hit>
              <date n="{string($date/@n)}">{string($date/@when)}</date>
           </hit>
         }
</results>
};


declare function vac:element-search-page($hits as node()*, $query as element(query)) as element(results) {
let $max := count($hits)
let $first := xs:integer($query/start)
let $last := min(($max,$first +  xs:integer($query/hitsPerPage) - 1))
return
<results max = "{$max}" first="{$first}" last="{$last}">
       {   for $hit in $hits[position() = ( $first to $last)]
           let $score := ft:score($hit)
           let $date := $hit/preceding::tei:dateline[1]/tei:date/@when
           let $n := $hit/preceding::tei:dateline[1]/tei:date/@n
           return  
           <hit> 
              <id>{string($hit/@xml:id)}</id>
              <date n="{string($n)}">{string($date)}</date>
              <volume>{$hit/preceding::tei:title[@type="main"][1]}</volume>
              <score>{$score}</score>
              {vac:parents($hit)}
              {vac:extract($hit,$query)}
            </hit>
         }
</results>
};

(:  result analysis - group by date and order by ascending date :)
declare function vac:date-analysis ($results as element(results)) as element(analysis) {
<analysis dim="date">
   {for $date in distinct-values ($results/hit/date)
    let $occurrences := count($results/hit[date eq $date])
    let $name := $date
    let $n := $results/hit[date eq $date]/date/@n
    order by $date
    return
    <hits key="{$date}" occurrences ="{$occurrences}" name="{$name}" n="{distinct-values($n)}"/>
    }
</analysis>
};

(:  result analyses - group by delegate and order by occurrences :)
declare function vac:delegate-analysis ($results as element(results)) as element(analysis) {
<analysis dim="delegate">
   {for $key in distinct-values ($results/hit/delegate/@key)
    let $occurrences := count($results/hit[delegate/@key=$key])
    let $name := $vac:delegates[@key=$key]/@name
    order by $occurrences descending
    return
    <hits key="{$key}" occurrences ="{$occurrences}" name="{$name}"/>
    }
</analysis>
};

(:  result analyses - group by location and order by occurrences :)
declare function vac:location-analysis ($results as element(results)) as element(analysis) {
<analysis dim="location">
   {for $tgn in distinct-values ($results/hit/location/@tgn)
    let $occurrences := count($results/hit[location/@tgn=$tgn])
    let $loc := $vac:locations[@tgn=$tgn]
    order by $occurrences descending
    return
     <hits key="{$tgn}" occurrences ="{$occurrences}">{$loc/@*}</hits>
   }
</analysis>
};

(: sort hits as determined by parameters in $query :)
declare function vac:sort-results($results, $query) {
if (empty($query/order))
then $results
else 
<results>
  {if (vac:direction($query)="ascending")
   then 
      for $hit in $results/hit
      order by  vac:order($hit,$query)
      return $hit
    else
      for $hit in $results/hit
      order by  vac:order($hit,$query) descending
      return $hit
     }
</results>
};

(:  return the value to sort on based on $query  :)
declare function vac:order($hit,$query) {
  if($query/order="count") then $hit/count
  else if ($query/order="score") then $hit/score
  else if ($query/order="delegate") then $hit/delegate/@name  
  else if ($query/order="date") then $hit/date
  else if ($query/order="location") then $hit/location[1]/@name
  else ()
};

(:  return the direction of sort based on $query  :)
declare function vac:direction($query) as xs:string {
  if ($query/direction ne "") 
  then $query/direction/string()
  else 
  if($query/order="count") then "descending"
  else if ($query/order="score") then "descending"
  else if ($query/order="delegate") then "ascending"
  else if ($query/order="date") then "ascending"
  else if ($query/order="location") then "ascending"
  else "ascending"
};


declare function vac:highlight-text($text,$keywords) {
  if (empty($keywords))
  then
      let $p := replace($text,"&amp;","&amp;amp;")
      let $p-parsed := util:parse(concat("&lt;span>",$p,"&lt;/span>"))
      return 
           $p-parsed/*/node()
  else 
     let $keyword := $keywords[1]
     let $pattern :=  concat("(^|\W)(",$keyword,")($|\W)") 
     return
         if (matches($text,$pattern,"im"))
         then  
            let $newText := replace($text,$pattern,"&lt;hi>$1$2$3&lt;/hi>","im")
            return
                vac:highlight-text($newText,subsequence($keywords,2))
         else 
            vac:highlight-text($text,subsequence($keywords,2))
};


declare function vac:highlight-node($node,$keywords) {
   element {node-name($node)}
      {$node/@*,
          for $child in $node/node()
              return
               if ($child instance of element())
               then vac:highlight-node($child,$keywords)
               else  
                  vac:highlight-text($child,$keywords)
      }
};

declare function vac:ft-query-to-keywords($ft) {
    for $t in $ft//*
    return
        typeswitch ($t)
        case element(term)
             return string($t)
        case element(wildcard)
             return replace($t,"\*",".*?")
        default return ()   
};

(:~
 : this function retrieves a trimmed subtree from a TEI document between a pb element and the following pb element
 : using trim-node() and if a query with ft defined, the page is highlighted
 : 
 : @param startPage  - the id of the first pagebreak node (assumed to be unique within the corpus
:)
declare function vac:page($startPage as element(tei:pb), $query as element(query)? ) as node() {
let $endPage := $startPage/following::tei:pb[1] 
let $endPage := if ($endPage) then $endPage else root($startPage)//node()[last()] 
let $subtree := vac:trim-node($startPage,$endPage)
let $date := $startPage/preceding::tei:dateline[1]/tei:date/@when
let $keywords := vac:ft-query-to-keywords($query/ft)
return
<page
    n="{$startPage/@n}"
    pbid="{$startPage/@xml:id}"
    when="{$date}">
    {if ($query)
     then vac:highlight-node($subtree,$keywords)
     else $subtree
    }
 </page>
};

(:~ as page() without a query to highlight the page
:)
declare function vac:page($startPage as element(tei:pb)) as node() {
  vac:page($startPage,())
};


(:~  trim the XML from $nodes $start to $end 
 :   The algorithm is 
 : 1) find  all the ancestors of this node - $startParents
 : 2) find the next pb node and all the ancestors - $endParents
 : 5) recursively, starting with the common top we create a new element which is a copy of the element being trimmed by 
 :    5.1 copying all attributes 
 :    5.2 expanding the node name if applicable (a Richmond req)
 :    5.3 there are four cases depending on the node and the left and right edges of the tree
 :     a) left and right children are the same - nothing else to copy
 :     b) both children are in the node's children - trim the left one, copy the intervening children and trim the right one
 :     c) only the left child is in the node's children - trim the node and copy the following siblings
 :     d) only the right edge is in the node's children  - copy the preceding siblings and trim the node
 :    attributes (currently in the secession namespace since its not a TEI attribute) are added to trimmed nodes  
:)
declare function vac:trim-node($start,$end) {
let $startParents := $start/ancestor-or-self::*
let $endParents := $end/ancestor-or-self::*
let $top := $startParents[1]
return
   vac:trim-node($top,subsequence($startParents,2),subsequence($endParents,2))
};

declare function vac:trim-node($node, $left, $right) {
       if (empty($left) and empty($right)) 
       then $node  (: leaf is untrimmed :)
       else 
          let $leftNode := $left[1]
          let $rightNode:= $right[1]
          let $children := $node/node()
          let $name := if ($node/@xml:id) 
                       then $vac:index//*[@xml:id = $node/@xml:id]/@name
                       else ()
          return
            element {node-name($node)} {
              $node/@* , (: copy all the attributes :)
              if ($name) then attribute vac:name {$name} else (),
              if ($leftNode is $rightNode)  (: edge node  is common :)
              then vac:trim-node($leftNode, subsequence($left,2),subsequence($right,2))
              else 
              if ($leftNode = $node/node() and $rightNode = $node/node())  (: both in same subtree :)
              then (
                    if ($leftNode/preceding-sibling::node()) 
                    then attribute vac:trimmed-preceding {"true"}
                    else (),
                    if ($rightNode/following-sibling::node()) 
                    then attribute vac:trimmed-following {"true"}
                    else (),
                    vac:trim-node($leftNode, subsequence($left,2),()),  (: first the trimmed left node :)
                         
                         (: then the siblings between left and right nodes :)
                                                                      
                    $leftNode/following-sibling::node() except $rightNode/following-sibling::node() except $rightNode,
                    
                    vac:trim-node($rightNode, (), subsequence($right,2))  (: then the trimmed right node :)      
                   )
              else if ($leftNode = $node/node())  (: left node is in the children :)
              then 
                 ( if ($leftNode/preceding-sibling::node()) 
                   then attribute vac:trimmed-preceding {"true"}
                   else (),
                   vac:trim-node($leftNode, subsequence($left,2),()),  (: first the trimmed left node :)
                   $leftNode/following-sibling::node()              (: then  the following siblings :)
                 )
              else if ($rightNode = $node/node())   (: right node is in the children :)
              then 
                 ( if ($rightNode/following-sibling::node()) 
                    then attribute vac:trimmed-following {"true"}
                    else (),
                    $rightNode/preceding-sibling::node(),                  (: the preceding siblings :)
                    vac:trim-node($rightNode, (), subsequence($right,2))  (: then the trimmed right node :)              
                 )
              else ()      
            }
};

(: page accesses :)
(:~  create a sequence of elements which the ancestors or the node node itself of the given node, extended with
  :   the name of the node found by lookup in the index document
  :@param $node - the node whose parents are required 
  :@return a sequence of parent nodes, each describing the node itself or a parent node together with the name if the node is in the index
:)
declare function vac:parents($node ){
     for $p in $node/ancestor-or-self::*[@xml:id]
     let $name := $vac:index/id($p/@xml:id)/@name
     return
       <parent id="{$p/@xml:id}">
          {if ($name) then attribute name {$name} else () }
       </parent>
        
};

(:~
  :  return the tei:pb elements which encompass the supplied node
  :
  :@param $node the node whose pages are required
  :@return the sequence of pb elements in document order on which the node resides
:)
declare function vac:pages($node) {
  (
   $node/preceding::tei:pb[1] ,
    $node//tei:pb
  )
};

(:~ return a node given its id
  :
  :@param $id  the xml:id of the required page break
  :@return the node in $vac:data
:)
declare function vac:node($id) {
  collection($vac:data)/id($id)
};

(:~ for any node, return the first page break of that node i.e. the preceding page break 
  :
  :@param $id  the xml:id of the required page break
  :@return 

:)
declare function vac:page-of-node($id) {
  vac:node($id)/preceding::tei:pb[1] 
};


(:  access to the reference files :)
declare function vac:master-events($startDate as xs:date, $endDate as xs:date){
    $vac:events//event[xs:date(@start) >= $startDate and xs:date(@start) <= $endDate]
};



