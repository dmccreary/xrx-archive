xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $code-table-collection := concat($style:web-path-to-app, '/code-tables/')

return
<code-tables>
   <collection>{$code-table-collection}</collection>
   {doc(concat($code-table-collection, 'message-classification-codes.xml'))/code-table}
</code-tables>