xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace edm="http://education.state.mn.us/datadictionary/1.0";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace e="http://education.state.mn.us/datadictionary/owl/education#";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'OWL Classes'

let $data-collection := style:app-data-uri()
let $file := request:get-parameter('file', 'education.owl')
let $file-path := concat($data-collection, '/', $file)

return
<html>
    <head>
       <title>{$title}</title>
       {style:import-css()}
    </head>
    <body>
     <div id="main">
     {style:header()}
          <div id="content">
          {style:breadcrumb()}
      <p>Sample Queries on OWL Files</p>
      <file>{$file-path}</file>
      <ol>
      {for $class in doc($file-path)/rdf:rdf/owl:class
       let $class-name := substring-after(string($class/@rdf:about),'#')
       let $subclass-name  :=
          concat(substring-after(string($class/rdfs:subclassof/@rdf:resource), '#'),
          substring-after(string($class/rdfs:subclassof/owl:class/@rdf:about), '#'))
      return
        <li>{$class-name} {string($class/@rdf:id)} 
        (
        <a href="03-properties-for-class.xq?class={$subclass-name}">
       {$subclass-name}
        </a>
        )</li>
      }
      </ol>
      </div>
      {style:footer()}
      </div>
    </body>
</html>

