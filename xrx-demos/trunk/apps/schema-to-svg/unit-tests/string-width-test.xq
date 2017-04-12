xquery version "1.0";

import module namespace svg-util='http://code.google.com/p/xrx/svg-util' at '../modules/svg-util.xqm';
import module namespace sch-util="http://code.google.com/p/xrx/schema-util" at "../modules/schema-utils.xqm";
import module namespace xsd2svg="http://danmccreary.com/xsd2svg" at "../modules/xml-schema-2-svg.xqm";

let $serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')

let $all-element-names := $sch-util:all-element-names

return
<svg xmlns:svg="http://www.w3.org/2000/svg">
   {$xsd2svg:css}
   {for $name at $count in $all-element-names
    let $text-box-width := svg-util:string-width($name)
    return
    <g transform="translate(20 {$count * 50})">
        <line x1="0" x2="10" y1="14" y2="14" stroke="black" stroke-width="2"/>
        <rect x="10" y="0" rx="5" ry="5" width="{$text-box-width}" height="28" class="xsd-required"/>
        <text x="15" y="20" class="xsd-text">{$name}</text>
        <text x="15" y="40" class="annotation-text">{$text-box-width}</text>
    </g>}
    
    {$sch-util:all-element-names}
</svg>
