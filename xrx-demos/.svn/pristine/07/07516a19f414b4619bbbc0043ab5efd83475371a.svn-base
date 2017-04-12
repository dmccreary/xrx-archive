xquery version "1.0";
 
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
 
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
 
let $title := 'List of OWL Classes'
 
let $data-collection := '/db/dma/apps/owl/data'
let $file := request:get-parameter('file', 'accident.rdf')
let $file-path := concat($data-collection, '/', $file)
 
(: we only want classes that have an ID.  Other classes are not named classes. :)
let $all-classes := doc($file-path)//owl:Class

let $classes := doc($file-path)//owl:Class

return
<html>
    <head>
 <link rel="stylesheet" type="text/css" href="cdesign.css"  />
       <title>{$title}</title>
 <script type="text/javascript" src="jquery.js"></script>
    </head>
    <body>
      <file>File Path: {$file-path}</file>
      <p>Number of Classes = {count($classes)}</p>
      <ol>
      {for $class in $classes
         
         let $class-name := string($class/@rdf:about)
         return
           <option>{$class-name}</option>
      }
      </ol>

      <select >
      {for $class in $classes//owl:Class[@rdf:about][rdfs:subClassOf/@rdf:resource="#Causes_Possibles"]

         let $class-name := string($class/@rdf:about)
         return
           <option>{$class-name}</option>
      }
      </select>
   
    </body>
</html>