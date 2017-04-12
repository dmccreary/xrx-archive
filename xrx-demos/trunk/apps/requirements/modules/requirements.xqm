module namespace req="http://www.mnhs.org/requirements";

(: the URI of the application :)
declare function req:app-uri() as xs:string {
  '/db/surescripts/apps/requirements'
};

(: the URI of the application :)
declare function req:app-url() as xs:string {
  concat('/rest', req:app-uri())
};

(: the URI of the code tables collection :)
declare function req:code-table-collection() as xs:string {
  concat(req:app-uri(), '/code-tables')
};

(: the URI of the code tables collection :)
declare function req:data-collection() as xs:string {
  concat(req:app-uri(), '/data')
};

(: the URI of the requirements priority code table file path :)
declare function req:priority-codes-file() as xs:string {
  concat(req:code-table-collection(), '/RequirementPriorityCodes.xml')
};

(: the full RequirementPriorityCode.xml file :)
declare function req:priority-codes() as node()* {
  doc(concat(req:code-table-collection(), '/RequirementPriorityCodes.xml'))
};

(: converts a priority string to an integer :)
declare function req:priority-value-to-int($code-string as xs:string?) as xs:int? {
   let $priority-codes := xs:int(req:priority-codes()/CodeTable/items/item[value=$code-string]/rank/text())
   return $priority-codes
};

(: converts ID to URI :)
declare function req:id-to-uri($id as xs:string?) as xs:string {
  concat(req:data-collection(), '/', $id, ".xml")
};

(: converts a requirment ID to a requirment name :)
declare function req:id-to-name($id as xs:string?) as xs:string? {
  doc(req:id-to-uri($id))/Requirement/RequirementShortName/text()
};

(: if any of the classifiers are architecturally-significant then true :)
declare function req:architecturally-significant($requirement as node()) as xs:boolean {
   if ($requirement/RequirementClassifierCode/text() = 'architecturally-significant')
   then true()
   else false()
};

(: if any requirement has this node as a parent then we are not a leaf and return false() else true() :)
declare function req:is-leaf($id as xs:string) as xs:boolean {
   if (collection(req:data-collection())//RequirementParentID/text() = $id)
   then false()
   else true()
};

declare function req:code-table() as node() {
let $requirements := collection(req:data-collection())/Requirement

return
<code-table>
   <code-table-name>Requirements</code-table-name>
   <items>{
    for $requirement in $requirements
    let $name := $requirement/RequirementShortName/text()
    order by $name
    return
       <item>
          <label>{$name}</label>
          <value>{$requirement/id/text()}</value>
       </item>
}</items>
</code-table>
};