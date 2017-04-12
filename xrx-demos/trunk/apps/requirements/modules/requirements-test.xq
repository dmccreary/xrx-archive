import module namespace req='http://www.mnhs.org/requirements' at 'requirements.xqm';

let $title := 'Unit test for requirments manager module'

return
<results>
   <app-uri>{req:app-uri()}</app-uri>
   <app-url>{req:app-url()}</app-url>
   <code-table-collection>{req:code-table-collection()}</code-table-collection>
   <priority-codes-file>{req:priority-codes-file()}</priority-codes-file>
   { (: <priority-codes>{req:priority-codes()}</priority-codes> :) let $x := '' return '' }
   <priority-value-to-int>{req:priority-value-to-int('very-low')}</priority-value-to-int>
   <priority-value-to-int>{req:priority-value-to-int('critical')}</priority-value-to-int>
   <!-- this should be true -->
   <architecturally-significant>{req:architecturally-significant(
    doc('/db/cust/mhs/apps/requirements/data/16.xml')/Requirement
   )}</architecturally-significant>
   <!-- this should be false -->
   <architecturally-significant>{req:architecturally-significant(
    doc('/db/cust/mhs/apps/requirements/data/1.xml')/Requirement
   )}</architecturally-significant>
</results>