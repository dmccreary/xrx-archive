xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

let $code-table-collection := concat($style:db-path-to-app, '/code-tables/')

return
<CodeTables>
   {doc(concat($code-table-collection, 'approvers.xml'))/code-table}
   {doc(concat($code-table-collection, 'classifiers.xml'))/code-table}
   {doc(concat($code-table-collection, 'RequirementCompletionStatusCodes.xml'))/code-table}
   {doc(concat($code-table-collection, 'RequirementTestableCodes.xml'))/code-table}
   {doc(concat($code-table-collection, 'RequirementPriorityCodes.xml'))/code-table}
   {doc(concat($code-table-collection, 'RequirementReleaseCodes.xml'))/code-table}
   {doc(concat($code-table-collection, 'staff-codes.xml'))/code-table}
   {util:eval(xs:anyURI('../code-tables/short-names.xq'))}
</CodeTables>