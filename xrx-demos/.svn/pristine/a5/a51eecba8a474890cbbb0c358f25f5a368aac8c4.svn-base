xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";


declare namespace sch="http://purl.oclc.org/dsdl/schematron";


let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')

let $q := request:get-parameter('q', "")

(: put the search results into memory :)
let $search-results := collection($data-collection)/sch:schema[contains(sch:title/text() , $q)]
let $count := count($search-results)
let $title :='Rule Search Results'

let $content :=
<div class="content">
        <p><b>Search results for:</b>&quot;{$q}&quot; <b> In Collection: </b>{$data-collection}</p>
        <p><b>Rules Found: </b>{$count}</p>
     <ol>{

(: find all the glossary element values of person that match this string :)
(:    for $term in collection($data-collection)//Term[*/text() &= $search-string ] :)
   for $hit in $search-results
      let $id := $hit/id
      let $rule-title := $hit/sch:title/text()
   return
      <li><a href="../views/view-single-rule-set.xq?id={$id}">{$rule-title}</a></li>
      }</ol>
      
      
     <div class="edit-controls">
        <a href="search-form.xq">New Seach</a>
     </div>
 </div>
 
 return style:assemble-page($title, $content)
  