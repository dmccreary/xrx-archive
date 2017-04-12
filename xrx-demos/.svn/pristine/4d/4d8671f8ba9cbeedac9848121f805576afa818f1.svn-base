xquery version "1.0";

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";

(: all-codes.xq - get all the code tables for an XForms edit form :)

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $code-tables-collection := concat($style:db-path-to-app, '/code-tables')

return
<code-tables>
   <!-- Code Tables used in the Template Edit XForms Application -->
   {doc(concat($code-tables-collection, '/category-codes.xml'))}
   {doc(concat($code-tables-collection, '/publish-status-codes.xml'))}
   {doc(concat($code-tables-collection, '/template-codes.xml'))}
</code-tables>
