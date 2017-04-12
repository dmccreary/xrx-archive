xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

let $doc := '/db/mdr/patterns/eip/patterns2.xml'

let $count := count(doc($doc)/PatternLibrary/Pattern)

return
<html>
   <head>
      <title>Pattern R1</title>
      {cms:import-css-tables()}
   </head>
   <body>
       {cms:header()}

      <p><b>Pattern Count: </b>{$count}</p>
      <table border="1">
         <thead>
           <th>Classifier</th>
            <th>Name</th>
            <th>Image</th>
            <th>Ref</th>
            <th>Description</th>
        </thead>
            <tbody>{
                for $pattern at $count in doc($doc)/PatternLibrary/Pattern
                   let $name := $pattern/PatternName/text()
                order by $name
                return
                <tr>
                   <td>{$count}</td>
                    <td>{$pattern/Classifier/text()}</td>
                    <td>{$name}</td>
                    <td><img src="../images/{$pattern/Image/text()}"></img></td>
                    <td><a href="{$pattern/Reference/text()}">Ref</a></td>
                    <td>{$pattern/Description/text()}</td>
                </tr>
              }</tbody>
      </table>
    </body>
</html>

