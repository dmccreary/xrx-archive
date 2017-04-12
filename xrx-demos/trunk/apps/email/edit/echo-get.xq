xquery version "1.0";
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

let $title := 'Echo HTTP Get'

return
<results>
   <headers>{
   for $header in request:get-header-names()
      return
         <header>
           <name>{$header}</name>
           <value>{request:get-header($header)}</value>
         </header>
   }</headers>
   <parameters>
      {for $parameter in request:get-parameter-names()
           return
           <parameter>
              <name>{$parameter}</name>
              <value>{request:get-parameter($parameter, '')}</value>
           </parameter>
        }
   </parameters>
</results>

