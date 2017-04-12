xquery version "1.0";
import module namespace style='http://www.mnhs.org/style' at '/db/cust/mhs/modules/style.xqm';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'Search Example Dublin Core Metadata Records'

return
<html>
   <head>
    <title>{$title}</title>
     {style:import-css()}
   </head>
<body>
    {style:header()}
    {style:breadcrumb()}

       <a href="../views/list-items.xq">List all Items</a>
    <h2>{$title}</h2>
        <div id="searchform">
            <form method="GET" action="search.xq">
                <p>
                    <strong>Search:</strong>
                    <input name="q" type="text" value="" size="60"/>
                    <input type="submit" value="Search"/>
                </p>
            </form>
        </div>
         {style:footer()}
    </body>
</html>
