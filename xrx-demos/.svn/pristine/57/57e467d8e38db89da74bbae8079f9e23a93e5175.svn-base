xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

(: all-codes.xq: Collet all the code-tables and put them in a single XML document that will be use as an instance in the model. :)
(: This allows you to send all the codes using a single http GET and cuts down on the multiple GETS for each code table. :)

let $app-collection := $style:db-path-to-app
let $code-table-collection := concat($app-collection, '/code-tables')

let $project := doc(concat($code-table-collection, '/projects.xml'))

return
<codes>
   {$project}
</codes>
