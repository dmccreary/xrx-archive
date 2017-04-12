xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')

(: the search query string :)
let $q := request:get-parameter('q', '')

return
<html>
    <head>
       <title>Seach Results</title>
       {style:import-css()}
     </head>
     <body>
       {style:header()}
       {style:breadcrumb()}
       &gt;
      <a href="../index.xq">Dublin Core Home</a>
      &gt; <a href="../views/list-items.xq">List all Items</a>
        <h1>Search Results</h1>
        <p><b>Search results for: </b>{$q} <b> In collection: </b>{$data-collection}</p>
     <ol>{
        (: search any column that matchs this string :)
        for $hit in collection($data-collection)/item[*/text() &= $q]
        return
           <li><a href="../views/view-item.xq?id={$hit/id/text()}"> { $hit/title/text() } </a> - { $hit/description/text()} </li>
      }</ol>
      
      <a href="search-form.xq">New Search</a>
      <a href="../edit/edit.xq?new=true">New Item</a>
      <a href="../views/list-items.xq">List Items</a>
      {style:footer()}
   </body>
</html>
