xquery version "1.0";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $post-data := request:get-data()

return
<post-data>
   <headers>{request:get-header-names()} </headers>
   <parameters>
      {for $parameter in request:get-parameter-names()
       return
          <parameter>{$parameter}={request:get-parameter($parameter, '')}</parameter>
      }
   </parameters>
   <post-data>{$post-data}</post-data>
</post-data>
