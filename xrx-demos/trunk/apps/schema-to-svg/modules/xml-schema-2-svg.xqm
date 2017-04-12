xquery version "1.0";

module namespace xsd2svg="http://danmccreary.com/xsd2svg";
import module namespace svg-util='http://code.google.com/p/xrx/svg-util' at 'svg-util.xqm';
(: import module namespace xsd2svg="http://ttp://danmccreary.com/xsd2svg" at "../modules/xml-schema-2-svg.xqm"; :)

declare namespace xs="http://www.w3.org/2001/XMLSchema";

(: the module is a typeswitch dispatch transform mdoule :)

(: constants :)
declare variable $xsd2svg:element-height := 70;
declare variable $xsd2svg:debug := false();

(: this function takes the root element of an XML Schema as the input and returns the SVG file :)
declare function xsd2svg:main($input as node()*) as node()* {
  for $node in $input
  return
     typeswitch($node)
            case text() return $node
            case element(xs:schema) return xsd2svg:schema($node)
            case element(xs:element) return xsd2svg:element($node)
            case element(xs:sequence) return xsd2svg:sequence($node)
            case element(xs:choice) return xsd2svg:choice($node)
            case element(xs:any) return xsd2svg:any($node)
            case element(xs:simpleType) return xsd2svg:simpleType($node)
            case element(xs:annotation) return xsd2svg:skip($node)
            case element(xs:complexType) return xsd2svg:complexType($node)
            (: TODO
            case element(pattern) return xsd2svg:pattern($node)
            :)
            default return <unknown-element>{$node}</unknown-element>
};

declare function xsd2svg:schema($node as node()) as node() {
<svg 
    xmlns:svg="http://www.w3.org/2000/svg">
    <title>SVG Rendering of XML Schema File = {util:document-name($node)}</title>
    <style type="text/css"><![CDATA[
        .xsd-text {font-size: 14pt;
              font-family: Arial, Helvetica, sans-serif;
         }
         
         .xsd-required, .xsd-optional {
              fill:yellow;
              stroke:black;
              stroke-width:2;
              opacity:0.8;
          }
          
          .xsd-required {
          }
          
          /* five pixels on and five off */
          .xsd-optional {
            stroke-dasharray: 10, 10;
            stroke-width:2;
          }
          
          .card-text {
            font-size: 10pt;
            font-family: Arial, Helvetica, sans-serif;
          }
          
          .annotation-text {
            font-size: 10pt;
            font-family: Arial, Helvetica, sans-serif;
          }
          
          
    ]]></style>
    {xsd2svg:main($node/*)}
</svg>
};

(: this is where we draw each element in a box 
   the x and y are absolute page coordinates
   the name is the name of the element
   and the optional is if the element is required or optonal for the line around the box 
   the cardinality is for the 1 to N relationship
   and the annotation os for the text annotation of the node :)
   
declare function xsd2svg:element($node as node()) as node()* {
let $name := $node/@name/string()
let $sub-element-count := count($node//xs:element)
let $x := 100
let $y := $sub-element-count * $xsd2svg:element-height div 2
let $optional :=
   if ($node/@minOccurs = '0')
      then false()
      else true()

let $max-cardinality := $node/@minOccurs/string()
let $annotation := $node/xs:annotation/xs:documentation/text()
return
<g  transform="translate({$x} {$y})">
    <line x1="0" x2="10" y1="14" y2="14" stroke="black" stroke-width="2"/>
    <rect x="10" y="0" rx="5" ry="5" width="250" height="28" class="xsd-required"/>
    <text x="15" y="20" class="xsd-text">{$name}</text>
    <text x="15" y="45" class="annotation-text" fill="gray">{$max-cardinality}</text>
    <text x="20" y="60" class="annotation-text" fill="gray">{$annotation}</text>
</g>,xsd2svg:main($node/*)

};

declare function xsd2svg:complexType($node) as node() {
<g class="complexType">
   <line class="complexType"/>,
   {xsd2svg:main($node/*)}
</g>
};

declare function xsd2svg:simpleType($node) as node() {
<g class="simpleType">
   <line class="simpleType"/>,
   {xsd2svg:main($node/*)}
</g>
};

declare function xsd2svg:sequence($node as node()) as node() {
<g class="sequence">
    <g transform="translate(50, 20)" class="sequence">
        <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
        <circle fill="black" r="5" cx="15" cy="25"/>
        <circle fill="black" r="5" cx="30" cy="25"/>
        <circle fill="black" r="5" cx="45" cy="25"/>
        <line x1="2" y1="25" x2="58" y2="25" stroke="black"/>
    </g>
    {for $ele at $count in $node/xs:element
          return
             <g transform="translate(50, {$count})">
                {xsd2svg:element($ele)}
             </g>
     }
</g>
};
    
declare function xsd2svg:choice($node as node()) as node() {
<g transform="translate(50, 105)" class="choice">
    <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
    <circle fill="black" r="5" cx="30" cy="12"/>
    <circle fill="black" r="5" cx="30" cy="25"/>
    <circle fill="black" r="5" cx="30" cy="38"/>
    <line x1="2" y1="25" x2="12" y2="25" stroke="black"/>
    <line x1="25" y1="25" x2="58" y2="25" stroke="black"/>
    <line x1="12" y1="25" x2="25" y2="12" stroke="black"/>
    <line x1="25" y1="12" x2="48" y2="12" stroke="black"/>
    <line x1="25" y1="38" x2="48" y2="38" stroke="black"/>
    <line x1="48" y1="12" x2="48" y2="38" stroke="black"/>
</g>
};



declare function xsd2svg:any($node as node()) as node() {
<g transform="translate(50, 190)" class="any">
    <polygon points="0,10 10,0 50,0 60,10  60,40 50,50  10,50 0,40" fill="none" stroke="black"></polygon>
    <circle fill="black" r="5" cx="30" cy="12"/>
    <circle fill="black" r="5" cx="30" cy="25"/>
    <circle fill="black" r="5" cx="30" cy="38"/>
    <line x1="2" y1="25" x2="58" y2="25" stroke="black"/>
    <line x1="12" y1="12" x2="48" y2="12" stroke="black"/>
    <line x1="12" y1="38" x2="48" y2="38" stroke="black"/>
    <line x1="12" y1="12" x2="12" y2="38" stroke="black"/>
    <line x1="48" y1="12" x2="48" y2="38" stroke="black"/>
</g>
};

declare function xsd2svg:skip($node) as node()? {
if ($xsd2svg:debug)
  then <skip/>
  else ()
};
