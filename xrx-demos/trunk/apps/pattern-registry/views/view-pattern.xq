xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=html media-type=text/html indent=yes";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

let $collection := '/db/mdr/patterns/eip/data'

let $name := request:get-parameter('name', '')
let $id := request:get-parameter('id', '')

let $pattern := if ($name)
   then collection($collection)/Pattern[PatternName=$name]
   else collection($collection)/Pattern[id=$id]
   
return
<html>
   <head>
      <title>Patter: {$name}</title>
      <style language="text/css">
  <![CDATA[
    tr th {text-align: right;}
  ]]>
  </style>
      {cms:import-css-tables()}
   </head>
   <body>
       {cms:header()}
     <a class="breadcrumb" href="../../../index.xhtml">Metadata Registry Home</a> &gt;
     <a class="breadcrumb" href="../../index.xhtml">Pattern Registry</a> &gt;
     <a class="breadcrumb" href="list-classifiers.xq">Classifiers</a> &gt;
     <a class="breadcrumb" href="list-patterns.xq">All Patterns</a>
     <p>View Pattern</p>
      <h1>{$name}</h1>
      <table border="0">
            <tbody>
                <tr>
                    <th>Classifier:</th><td><a href="list-patterns-with-classifier.xq?classifier={$pattern/Classifier/text()}">{$pattern/Classifier/text()}</a></td>
                </tr>
                <tr>
                    <th>Name:</th><td>{$name}</td>
                </tr>
                <tr>
                    <th>Image:</th><td><img src="../images/{$pattern/Image/text()}"></img></td>
                </tr>
                <tr>
                    <th>Ref:</th><td><a href="{$pattern/Reference/text()}">Ref</a></td>
                </tr>
                <tr>
                    <th>Description:</th><td>{$pattern/Description/text()}</td>
                </tr>
                <tr>
                    <th>Question:</th><td>{$pattern/Question/text()}</td>
                </tr>
                <tr>
                    <th>Answer:</th><td>{$pattern/Answer/text()}</td>
                </tr>
                <tr>
                    <th>Note:</th><td>{$pattern/NoteText/text()}</td>
                </tr>
          </tbody>
      </table>
      <p>
         <a href="../edit/edit.xq?id={$pattern/id/text()}">Edit</a>
         <a href="../edit/delete-confirm.xq?id={$pattern/id/text()}">Delete (confirm)</a>
      </p>
    </body>
</html>

