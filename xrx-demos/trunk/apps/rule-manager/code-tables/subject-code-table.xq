xquery version "1.0";
import module namespace style='http://mdr.crossflow.com/style' at '/db/crossflo/modules/style.xq';
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

(: subject-conditions.xq - used to populate an XForms suggest-items instance :)

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection, '/data')
let $doc-name := 'jiem-conditions.xml'
let $doc := concat($data-collection, '/', $doc-name)

return

<code-table>
   <code-table-name>subjects</code-table-name>
{
    for $subject in distinct-values( doc($doc)/conditions/condition/@subject )
       order by $subject
    return
      <item>
         <label>{$subject}</label>
         <value>{$subject}</value>
       </item>
}</code-table>
