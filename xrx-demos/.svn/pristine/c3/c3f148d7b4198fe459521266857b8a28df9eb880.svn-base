xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $code-table-collection := concat($style:db-path-to-app, '/code-tables/')

return
<CodeTables>     
   {doc(concat($code-table-collection, 'EmployeeContractorStatusCodes.xml'))/code-table}
   {doc(concat($code-table-collection, 'EmployeeRoleCodes.xml'))/code-table} 
   {doc(concat($code-table-collection, 'USStateCodes.xml'))/code-table}
</CodeTables>
