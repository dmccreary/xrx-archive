xquery version "1.0";

(: Home Page :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'Dublin Core Template Application'

let $content := 
<div class="content">
       <h1>{$title}</h1>
       <p>This application was created to show how data can be easily extracted from the body document and transformed into
       metadata that could be placed in the header of any view.  In this case our document is just 15 Dublin core tags.
       There are three formats.  Simple HTML with no metadata, HTML with Metadata tags and HTML with RDF tags.</p>
       <ol>
          <li>
             <a href="views/list-items.xq">List</a> List of Dublin Core Records
          </li>
          <li>
             <a href="edit/edit.xq?new=true">New</a> Create New Dublin Core Record
          </li>
          <li>
             <a href="search/search-form-html.xq">Search</a> Search Dublin Core Records
          </li>
          <li>
             <a href="views/metrics.xq">Metrics</a> Counts of various Dublin Core Records
          </li>
       </ol>
</div>

return 
    style:assemble-page($title, $content)