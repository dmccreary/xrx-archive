xquery version "1.0";

let $serialize := util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')

let $title := 'draw red circle'

return
<svg xmlns:svg="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
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
             stroke: black;
             fill: lightblue;
          }
          
          /* five pixels on and five off */
          .xsd-optional {
            stroke-dasharray: 10, 10;
            stroke-width:2;
            fill: lightblue;
            stroke: gray;
          }
          
          .card-text {
            font-size: 10pt;
            font-family: Arial, Helvetica, sans-serif;
          }
          
          .annotation-text {
            font-size: 10pt;
            font-family: Arial, Helvetica, sans-serif;
            color: gray;
          }
          
          
    ]]></style>
    <g class="element" transform="translate(0, 20)">
        <rect x="50" y="0" height="25" width="170" stroke="black" stroke-width="2" fill="lightblue" rx="5" ry="5"/>
        <text class="xsd-text" x="53" y="20">PersonGivenName</text>
        <text class="annotation-text" x="53" y="40">The name given to a person at birth.</text>
    </g>
    
     <g class="element" transform="translate(0, 80)">
        <rect class="xsd-optional" x="50" y="0" height="25" width="180" stroke-width="2" fill="lightblue" rx="5" ry="5"/>
        <text class="xsd-text" x="53" y="20">PersonMiddleName</text>
        <text class="annotation-text" x="53" y="40">The middle name of a person.</text>
    </g>
    
     <g class="element" transform="translate(0, 140)">
        <rect class="xsd-required" x="50" y="0" height="25" width="150" stroke="black" stroke-width="2" fill="lightblue" rx="5" ry="5"/>
        <text class="xsd-text" x="53" y="20">PersonSurName</text>
        <text class="annotation-text" x="53" y="40">The family or last name.</text>
    </g>
    
    <g class="element" transform="translate(0, 200)">
        <rect x="50" y="0" height="25" width="75" stroke="black" stroke-width="2" fill="lightblue" rx="5" ry="5"/>
        <text class="xsd-text" x="53" y="20">MWMW</text>
        <text class="annotation-text" x="53" y="40">A very wide name</text>
    </g>
    
    <g class="element" transform="translate(0, 260)">
        <rect x="50" y="0" height="25" width="30" stroke="black" stroke-width="2" fill="lightblue" rx="5" ry="5"/>
        <text class="xsd-text" x="53" y="20">ijl1</text>
        <text class="annotation-text" x="53" y="40">A very narrow name</text>
    </g>
</svg>
