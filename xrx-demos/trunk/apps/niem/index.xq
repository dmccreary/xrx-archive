xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'XRX Template Application'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application can be used as a basis for building other standard applications</p>
      
      
      <a href="views/get-documentation-from-schema.xq">Get Documentation from XML Schema</a> A listing of items<br/>
      
      <a href="output/ContactsDocument.xhtml">NIEM XML Schema to XForms Contacts Document</a> A listing of items<br/>
      <!--
      <a href="edit/edit.xq?new=true">New item</a> Create a new item<br/>
      
      <a href="search/search-contains-form.xq">Search Contains</a> Search for an item<br/>
      
      <a href="search/search-fulltext-form.xq">Search Fulltext</a> Search for an item<br/> 
      
      <a href="views/metrics.xq">Metrics</a> Template Metrics<br/><br/> 
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
