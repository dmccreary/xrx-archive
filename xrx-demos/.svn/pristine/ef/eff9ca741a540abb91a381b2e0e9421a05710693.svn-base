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
     <a class="breadcrumb" href="../index.xhtml">Integratnion Patterns</a>
      <p><b>Pattern Classifiers: </b>{$count}</p>
      <table border="1">
         <thead>
           <th>Classifier</th>
            <th>Count</th>
        </thead>
            <tbody>{
                for $classifier in distinct-values(collection($collection)/Pattern/Classifier)
                order by $classifier
                return
                <tr>
                    <td><a href="list-patterns-with-classifier.xq?classifier={$classifier}">{$classifier}</a></td>
                    <td>{count(collection($collection)/Pattern[Classifier=$classifier])}</td>
                </tr>
              }</tbody>
      </table>
    </body>
</html>

