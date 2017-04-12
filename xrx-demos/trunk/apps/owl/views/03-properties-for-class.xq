xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace edm="http://education.state.mn.us/datadictionary/1.0";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace e="http://education.state.mn.us/datadictionary/owl/education#";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'OWL Properties for Class'

let $data-collection := $style:db-path-to-app-data
let $file := request:get-parameter('file', 'education.owl')
let $class := request:get-parameter('class', 'Thing')
let $file-path := concat($data-collection, '/', $file)

let $content :=
<div class="content">
      <h1>Properties for {$class}</h1>
      <p>Properties for {$class} for ontology {$file}</p>
      XML: <a href="{$file-path}">{$file-path}</a>
      <ol>
      {for $property in doc($file-path)/rdf:rdf/owl:datatypeproperty[rdfs:domain/@rdf:resource=$class]
      return
        <li>{string($property/@rdf:id)}</li>
      }
      </ol>
</div>


return style:assemble-page($title, $content)

