xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';
declare namespace rdf = "http://www.semanticweb.org/ontologies/accident.rdf#";
declare namespace owl="http://www.w3.org/2002/07/owl#";
declare namespace rdfs="http://www.w3.org/2000/01/rdf-schema#";
declare default element namespace "http://www.semanticweb.org/ontologies/accident.rdf#";

let $title := 'Metrics for RDF File'
let $file := request:get-parameter('file', 'accident.rdf')
let $file-path := concat($style:db-path-to-app-data, '/', $file)

let $doc := doc($file-path)/*

return
<results>
  <file-path>{$file-path}</file-path>
  <node-count>{count($doc//node())}</node-count>
  <owl:ObjectProperty-count>{count($doc//owl:ObjectProperty)}</owl:ObjectProperty-count>
  <owl:inverseOf-count>{count($doc//owl:inverseOf)}</owl:inverseOf-count>
  <owl:Class-count>{count($doc//owl:Class)}</owl:Class-count>
  <owl:Restriction-count>{count($doc//owl:Restriction)}</owl:Restriction-count>
  <owl:onProperty-count>{count($doc//owl:onProperty)}</owl:onProperty-count>
  <owl:allValuesFrom-count>{count($doc//owl:allValuesFrom)}</owl:allValuesFrom-count>
  
  <rdfs:subClassOf-count>{count($doc//rdfs:subClassOf)}</rdfs:subClassOf-count>
  
  <class-list>
     {for $class in $doc//owl:Class
     return
        <class>{$class/@*/string()}</class>
        }
  </class-list>
  
</results>