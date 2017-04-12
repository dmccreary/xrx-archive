xquery version "1.0";

(: List Items :)

import module namespace style = "http://danmccreary.com/style" at "../../modules/style.xqm";

let $title := 'XML to XForms'

let $content := 
<div class="content">
      <p>Welcome to the {$title} XRX application.
      
      This application is a demonstration of the process of converting an XML instance document
      directly into an XForms form.</p>
      
      
      <a href="views/xml2form.xq">Sample XML 2 Form</a> A sample of an XForms application created
      from an instance.<br/>
      
      
</div>

return 
    style:assemble-page($title, $content)
