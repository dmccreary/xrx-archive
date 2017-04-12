xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'NGram Search Demo'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application can be used as a basis for building other standard XRX applications</p>
      
      <a href="search/search-contains-form.xq">Search Contains</a> Search for an item<br/>
      
      <a href="search/search-lucene.xq">Search Lucene</a> Search for an item<br/>
      
      <a href="search/search-contains-ngram.xq">Search NGram</a> Search for an item using the NGram index<br/>
      
      <a href="search/search-ngram-wildcard.xq">Search NGram Wildcard</a> Search using wildcard NGram<br/>
      
      <a href="http://demo.exist-db.org/exist/functions/ngram">Ngram Search Functions</a><br/>
      
     
      <a href="views/list-items.xq">List items</a> A listing of records<br/>
      
      <a href="views/metrics.xq">Metrics</a> Template Metrics<br/><br/> 
      
      <a href="admin/index.xq">Admin</a> Application Administrator Functions
      <!--
      
      
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/>
      
      <a href="search/search-contains-form.xq">Search Contains</a> Search for an item<br/>
      
      <a href="search/search-fulltext-form.xq">Search Fulltext</a> Search for an item<br/> 
      
      
      -->
      
   {if (util2:is-dba())
        then
          <div class="admin-only">
             <a href="admin/index.xq">Admin</a> Application Administrator Functions
          </div>
        else ()
      }
   
</div>

return 
    style:assemble-page($title, $content)
