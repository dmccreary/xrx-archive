xquery version "1.0";
import module namespace style = "http://style.syntactica.com/ibm" at "/db/cust/ibm/modules/style.xqm";

declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";


(: traverse the taxonomy heirarchy using depth first search recursive decent :)
declare function local:get-child-classifiers(
   $doc as node(),
   $id as xs:string,
   $depth as xs:integer) as node()* {
   let $classifier := $doc/classifier[id/text()=$id]
    return
    <span>{
       if ($depth < 5)
       then (
                 <a href="view-item.xq?id={$id}" style="text-decoration: none;">
                 <span
                    style='
                    color: {$classifier/color/text()};
                    font-size: {count($doc/classifier[parent-id=$id])+(4-$depth)*4+10};
                    '>
                    {$classifier/classifier-label/text()}
                 </span>
                 </a>
              ,
              if (exists($doc/classifier[parent-id/text()=$id]))
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
   }</span>
};

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $file := request:get-parameter('file', 'rss-feeds.xml')

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-path := concat($data-collection, '/', $file)
return

<html>
 <head>
      <title>RSS Feed Keywork Tag Cloud</title>
        {style:import-css()}
    </head>
    <body>
      {style:header()}
      {style:breadcrumb()}
      <h3>RSS Feed Keywork Tag Cloud</h3>
      <div style="text-decoration: none;">
      {local:get-child-classifiers(doc($doc-path)/taxonomy, '0', 0)}
      </div>
      {style:footer()}
   </body>
</html>
