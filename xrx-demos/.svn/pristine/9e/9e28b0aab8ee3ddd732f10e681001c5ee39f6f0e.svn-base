xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace xf-util = "http://danmccreary.com/xforms-utils" at "../../../modules/xforms-utils.xqm";

(: all-codes.xq - get all the code tables for an XForms edit form :)

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $code-tables-collection := concat($style:db-path-to-app, '/code-tables')

return
<code-tables>
   <!-- Code Tables used in the Template Edit XForms Application -->
   {doc(concat($code-tables-collection, '/app-classifier-codes.xml'))}
   {doc(concat($code-tables-collection, '/publish-status-codes.xml'))}
   {doc(concat($code-tables-collection, '/license-type-codes.xml'))}
   

</code-tables>