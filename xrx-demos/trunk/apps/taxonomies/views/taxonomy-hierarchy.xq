xquery version "1.0";
import module namespace style ='http://danmccreary.com' at '../../../modules/style.xqm';

declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";


(: traverse the taxonomy heirarchy using depth first search recursive decent :)
declare function local:get-child-categorys(
   $doc as node(),
   $id as xs:string,
   $depth as xs:integer) as node()* {
   let $classifier := $doc/category[id/text()=$id]
    return
    <ul>{
       if ($depth < 5)
       then (
              <li><a href="view-item.xq?id={$id}">{$classifier/classifier-label/text()}</a></li>,
              if (exists($doc/category[parent-id/text()=$id]))
                 then (
                      for $sub-classifier in $doc/classifier[parent-id=$id]
                         return
                            local:get-child-classifiers($doc, $sub-classifier/id/text(), $depth + 1)
                      )
                 else ()
          )
       else (
           <error>
              <message>Error at {$id} exceeds depth of 5. </message>
             {$classifier}
           </error>
       )
   }</ul>
};

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $file := request:get-parameter('file', 'security-documents.xml')

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
return

<html>
 <head>
      <title>Taxonomy Hierarchy</title>
        {style:import-css()}
    </head>
    <body>
      {style:header()}
      {style:breadcrumb()}
      <h3>Taxonomy Hierarchy</h3>
      {local:get-child-categorys(doc($doc-path)/taxonomy, '0', 0)}
      {style:footer()}
   </body>
</html>
