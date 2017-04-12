xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $collection := '/db/dma/apps/faqs/data'
let $title := 'FAQ Search'
(: the search query string :)
let $q := request:get-parameter('q', '')

let $content :=
  <div class = "content">
    <h2>FAQ Search Results</h2>
    <p><b>Search results for: </b>{$q} <b> In collection: </b>{$collection}</p>
    <ol>{

(: search any column that matchs this string :)
for $hit in collection($collection)/faq[contains(lower-case(./question/text()), lower-case($q)) 
or contains(lower-case(./answer/text()), lower-case($q)) ]
  let $id := $hit/id/text()
     return
    
         <li><a href="../views/view-item.xq?id={ $hit/id/text()}"> {$hit/question/text()} </a></li>
   
    }</ol>
    
    <div id="searchform">
    <form method="GET" action="search.xq">
      <p>
        <strong>Search:</strong>
        <input name="q" type="text" value=""/>
        <input type="submit" value="Search"/>
      </p>
    </form>
  </div>
      
  </div>


return style:assemble-page($title, $content)