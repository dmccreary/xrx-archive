xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";
import module namespace email = "http://www.danmccreary.com/xrx/email" at "modules/email.xqm";

(: E-mail search application.
   @author Dan McCreary
   :)



let $title := 'E-Mail Message Manager'

let $content := 
    <div class="content">
       <p>Welcome to {$title}.</p>

       <p>This demo uses eXist to perform search and retreval on e-mail messages:
          <ol>
              <li>
                  <a href="views/list-items.xq">List</a> List of all e-mail messages
              </li>
              
              <li>
                  <a href="search/search-form.xq">Search</a> Simple keyword search form
              </li>
              
              <li>
                  <a href="search/search-custom.xq">Custom Search</a> Custom search form
              </li>
              
              <li>
                  <a href="search/search-form-advanced.xq">Search Advanced</a> Advanced search form
              </li>
              
              <li>
                  <a href="views/metrics.xq">Metrics</a> Counts of various e-mail messages by category
              </li>
          </ol>
          
          <ol>
              <h3>XML Web Services</h3>
              <li>
                  <a href="edit/all-codes.xq">Code Tables</a> This is a list of all the codes that will be used in the application.
              </li>
         </ol>
         
         <ol>
              <h3>Administrative Tools</h3>
              <li>
                  <a href="views/list-code-tables.xq">List Code Tables</a> List Code Tables for Editing
              </li>
              <li>
                  <a href="edit/edit-code-table.xq?new=true">Create New Code Table</a> Form for creating a new code table
              </li>
              <li>
                  <a href="admin/reindex.xq">Reindex</a> Reindexes all messages.
              </li>
         </ol>
         
         <ol>
              <h3>Testing Tools</h3>
              <li>
                  <a href="catch/test-catch-service.xq">Test Catch Form</a> A form for testing the catch service
              </li>

         </ol>
        </p>
     </div>
     
return
    style:assemble-page($title, $content)