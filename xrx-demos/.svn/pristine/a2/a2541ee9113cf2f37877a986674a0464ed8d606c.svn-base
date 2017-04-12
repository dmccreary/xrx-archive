xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
<html>
   <head>
    <title>Item Search</title>
     {style:import-css()}
   </head>
<body>
    {style:header()}
    {style:breadcrumb()}
    <h1>Item Search</h1>
        <div id="searchform">
            <form method="GET" action="search.xq">
                <p>
                    <strong>Search:</strong>
                    <input name="q" type="text" value=""/>
                </p>
                <p>
                    <input type="submit" value="Search"/>
                </p>
            </form>
        </div>
         {style:footer()}
    </body>
</html>
