xquery version "1.0";

let $title := 'Echo Post'

return
<results>
  <title>{$title}</title>
  <get-data>
  {request:get-data()}
  </get-data>
  <headers>
  {for $header in request:get-header-names()
  return
     <header name="{$header}" value="{request:get-header($header)}"/>
  }
  </headers>
  
  <parameters>
  {for $parameter in request:get-parameter-names()
     return
        <parameter name="{$parameter}" value="{request:get-parameter($parameter, '')}"/>
  }
  </parameters>
</results>
