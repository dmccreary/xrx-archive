xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
 
let $starts-with := request:get-parameter('starts-with', 'A')

let $sp := ' '
return
<html>
    <head>
        <title>Data Elements A-Z</title>
        {style:import-css()}
    </head>
    <body>
        {style:header()}
        {style:breadcrumb()}
        <h1>Data Elements A-Z</h1>
        <div class="nav-bar">
            <a href="starts-with.xq?starts-with=A">A</a>{$sp}
            <a href="starts-with.xq?starts-with=B">B</a>{$sp}
            <a href="starts-with.xq?starts-with=C">C</a>{$sp}
            <a href="starts-with.xq?starts-with=D">D</a>{$sp}
            <a href="starts-with.xq?starts-with=E">E</a>{$sp}
            <a href="starts-with.xq?starts-with=F">F</a>{$sp}
            <a href="starts-with.xq?starts-with=G">G</a>{$sp}
            <a href="starts-with.xq?starts-with=H">H</a>{$sp}
            <a href="starts-with.xq?starts-with=I">I</a>{$sp}
            <a href="starts-with.xq?starts-with=J">J</a>{$sp}
            <a href="starts-with.xq?starts-with=K">K</a>{$sp}
             <a href="starts-with.xq?starts-with=L">L</a>{$sp}
            <a href="starts-with.xq?starts-with=M">M</a>{$sp}
            <a href="starts-with.xq?starts-with=N">N</a>{$sp}
            <a href="starts-with.xq?starts-with=O">O</a>{$sp}
            <a href="starts-with.xq?starts-with=P">P</a>{$sp}
            <a href="starts-with.xq?starts-with=Q">Q</a>{$sp}
            <a href="starts-with.xq?starts-with=R">R</a>{$sp}
            <a href="starts-with.xq?starts-with=S">S</a>{$sp}
            <a href="starts-with.xq?starts-with=T">T</a>{$sp}
            <a href="starts-with.xq?starts-with=U">U</a>{$sp}
            <a href="starts-with.xq?starts-with=V">V</a>{$sp}
            <a href="starts-with.xq?starts-with=W">W</a>{$sp}
            <a href="starts-with.xq?starts-with=X">X</a>{$sp}
            <a href="starts-with.xq?starts-with=Y">Y</a>{$sp}
            <a href="starts-with.xq?starts-with=Z">Z</a>{$sp}
            <a href="starts-with.xq?starts-with=1">1</a>{$sp}
         </div>
        <p><b>Report generation date-time: </b> {current-dateTime()}.  <b>Sort:</b> Case insensitive alphabetical by term.</p>
        <dl>
        {
         for $data-element in collection($data-collection)/DataElement
            let $data-element-name := $term/DataElementName/text()

            order by $data-element-name
            return
               <dt><a href="view-item.xq?id={$term/id/text()}">{$data-element-name}</a>{$acronym}<dd>{$term/DataElementDefinition/text()}</dd> </dt>
      }
      </dl>
</html>
