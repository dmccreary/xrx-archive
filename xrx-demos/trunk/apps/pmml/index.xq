xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../modules/util2.xqm";

let $title := 'Predictive Model Markup Language'

let $content := 
<div class="content">
      <p>Welcome to the {$title}.
      
      This application can be used as a basis for building applications that predict future events based on historical event data.</p>
      
      <a href="views/list-items.xq">List models</a> A listing of predictive models<br/>
      <br/>
      <h3>PMML References</h3>
      <a href="http://en.wikipedia.org/wiki/Predictive_Model_Markup_Language">Wikipedia Page on PMML</a><br/>
      <a href="http://www.dmg.org/v4-1/GeneralStructure.html">Structure of a PMML 4.1 Document</a><br/>
      
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
