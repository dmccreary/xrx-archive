xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

let $collection := '/db/mdr/patterns/eip/data'

let $count := count(collection($collection)/Pattern)

return
<html>
   <head>
      <title>Pattern R1</title>
      {cms:import-css-tables()}
   </head>
   <body>
       {cms:header()}
     <a class="breadcrumb" href="../../../index.xhtml">Metadata Registry Home</a> &gt;
     <a class="breadcrumb" href="../../index.xhtml">Pattern Registry</a> &gt;
     <a class="breadcrumb" href="../index.xhtml">Integratnion Patterns</a> &gt;
     <a class="breadcrumb" href="list-classifiers.xq">Classifier</a> 
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
                for $pattern in collection($collection)/Pattern
                   let $name := $pattern/PatternName/text()
                order by $name
                return
                <tr>
                    <td><a href="list-patterns-with-classifier.xq?classifier={$pattern/Classifier/text()}">{$pattern/Classifier/text()}</a></td>
                    <td><a href="view-pattern.xq?name={$name}">{$name}</a></td>
                    <td><img src="../images/{$pattern/Image/text()}"></img></td>
                    <td><a href="{$pattern/Reference/text()}">Ref</a></td>
                    <td>{$pattern/Description/text()}</td>
                </tr>
              }</tbody>
      </table>
    </body>
</html>

