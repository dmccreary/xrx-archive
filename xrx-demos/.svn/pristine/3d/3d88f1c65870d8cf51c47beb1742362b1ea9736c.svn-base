xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace edm="http://education.state.mn.us/datadictionary/1.0";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare namespace rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace e="http://education.state.mn.us/datadictionary/owl/education#";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $title := 'OWL Properties'

let $data-collection := $style:db-path-to-app-data
let $file := request:get-parameter('file', 'education.owl')
let $file-path := concat($data-collection, '/', $file)

let $content :=
<div class="content">
      <h1>{$title}</h1>
      <p>Sample Queries on OWL Files</p>
      XML: <a href="{$file-path}">{$file-path}</a>
      <ol>
      {for $property in doc($file-path)/rdf:rdf/owl:datatypeproperty
      return
        <li>{string($property/@rdf:id)}</li>
      }
      </ol>

</div>


return style:assemble-page($title, $content)
