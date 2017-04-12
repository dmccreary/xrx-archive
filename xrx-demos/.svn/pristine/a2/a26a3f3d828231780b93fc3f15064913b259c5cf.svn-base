xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'TEI Document Demos'

let $content := 
    <div>
       <p>Welcome to the TEI Play Manager.</p>
       <p>This demo does navigation and search of TEI documents:
          <ol>
              <li>
                  <a href="views/list-plays.xq">List</a> List of all Plays
              </li>
              <li>
                  <a href="search/search-form.xq">Search</a> Search for Play
              </li>
                           
          </ol>
          
          <h3>Admin</h3>
          <a href="admin/reindex.xq">Reindex the Collection</a> This takes about one minute<br/>
        </p>
     </div>
     
return
    style:assemble-page($title, $content)