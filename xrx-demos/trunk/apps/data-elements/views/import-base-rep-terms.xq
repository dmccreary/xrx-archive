xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
 
(: save-new.xq :)
let $app-collection := style:app-base-uri()
let $doc := concat($app-collection , '/ss-import/base-objects.xml')
return
<html>
    <head>
        <title>Distinct Representation Terms</title>
         {style:import-css()}
    </head>
    <body>
         {style:header()}
         {style:breadcrumb()}
        <h1>Representation Terms</h1>
        <p>{$doc}</p>
        {
        for $rep-term in distinct-values(doc($doc)/Objects/Object/RepresentationTerm/text() )

           order by $rep-term
          return
           <div>{$rep-term}</div>
       }
       {style:footer()}
    </body>
</html>

