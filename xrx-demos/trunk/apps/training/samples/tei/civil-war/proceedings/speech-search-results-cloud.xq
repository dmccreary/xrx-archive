declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace vac = "http://richmond.edu/ns/secession" at "../modules/secession.xqm";

let $noise := tokenize(
"the and a to of in i is that it on you this for but with are have be at 
 or as was so if out not my by may should here only she from your than did 
 under same what own its which before am these upon her there were could when
 after an me all they will had into nor mr sir t those can shall who his them 
 any been their would has our we then must some other such where while between 
 cannot because up while without whether another might within",
 "\s+")

let $query := vac:get-url-query()
let $results := vac:speech-search-hits-properties($query)

let $words := 
    for $hit in $results/hit
    let $speech := collection($vac:data)/id($hit/@id)
    return 
      tokenize(lower-case(string-join($speech//tei:p/text()," ")),'\W+')[ not (. = $noise)] [. ne ''] [not (matches(.,"\d+"))]
      
let $dwords := distinct-values($words)

let $wordCounts :=
     for $word in $dwords[position() < 25]
     let $count := count($words[. = $word]) 
     order by $count
     return
         <word count="{$count}">{$word}</word>

return
   <result hits ="{count($results/hit)}" noise-words="{count($noise)}" total-words="{count($words)}" distinct-words="{count($dwords)}">
    {$query}
    <speeches>{$results}</speeches>
    <counts>{$wordCounts}</counts>
   </result>
