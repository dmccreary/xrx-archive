xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

let $doc := '/db/mdr/patterns/eip/patterns.xml'

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
            <th>Description</th>
        </thead>
            <tbody>{
                for $pattern in doc($doc)/PatternLibrary/Pattern
                return
                <tr>
                    <td>{$pattern/Classifier/text()}</td>
                    <td>{$pattern/TD[2]/pattern-name/text()}</td>
                    <td><img>{$pattern/TD[1]/img/@src}</img></td>
                    <td>{$pattern/TD[3]/text()}</td>
                </tr>
              }</tbody>
      </table>
    </body>
</html>

