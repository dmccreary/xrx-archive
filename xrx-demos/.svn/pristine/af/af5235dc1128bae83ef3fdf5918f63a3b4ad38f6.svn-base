xquery version "1.0";
import module namespace style = "http://style.exist-db.org/reference-manual" at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html";

let $title := 'XRX Template Application'

return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <title>{$title}</title>
        {style:import-css()}
        </head>
        <body>
        <div id="main">
            {style:header()}

             {style:breadcrumb()}
               
             <h1>{$title}</h1>
             
             <h2>h2</h2>
             
             <p>Welcome to the Item Manager.  This demo uses w3c XForms and has been tested with FireFox 2.0 with the XForms addon.</p>
             <p>This demo allows you to manipulate Items using XForms and eXist using basic database operations CRUD (Create, Read/Search, Update, Delete) operations:
                <ol>
                    <li>
                        <a href="views/list-items">List</a> List of all Items
                    </li>
                    <li>
                        <a href="edit/edit?new=true">New</a> Create New Item
                    </li>
                    <li>
                        <a href="search/search-form">Search</a> Search for Items
                    </li>
                    <li>
                        <a href="views/list-categories">List Categories</a> List all Item Classifiers including status, category and tags
                    </li>
                    <li>
                        <a href="views/metrics">Item Metrics</a> Counts of various Item Metrics
                    </li>
                </ol>
          </p>

         {style:footer()}
         
         </div>
    </body>
</html>
