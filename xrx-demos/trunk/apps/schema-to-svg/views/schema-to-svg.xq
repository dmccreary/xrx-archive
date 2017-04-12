import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace schema-to-svg='http://danmccreary.com/schema-to-svg' at "../modules/schema-to-svg.xqm";


<svg width="100%" height="100%" version="1.1" xmlns="http://www.w3.org/2000/svg">
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

    <g>
       {for $i at $count in ('PersonBirthDate', 'PersonGenderCode', 'PersonFirstName', 'PersonLastName')
          return
             schema-to-svg:draw-element(10, $count * 70, $i, true(), '0..N', 'Annotation')}
    </g>
</svg>
