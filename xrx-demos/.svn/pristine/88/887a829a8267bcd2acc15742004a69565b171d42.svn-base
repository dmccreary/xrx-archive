xquery version "1.0";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
import module namespace date = "http://exist-db.org/xquery/admin-interface/date" at "/db/mdr/modules/date.xq";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xdb="http://exist-db.org/xquery/xmldb";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace transform="http://exist-db.org/xquery/transform";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";

(: compile-rule.xq Compile a Schematron rule-set file :)

let $ruleset := request:get-parameter('ruleset', "")
let $test := request:get-parameter('test', "")

let $ruleset-collection-path := 
   if ($test) then
   '/db/mdr/rules/schematron/test-rule-sets'
   else
   '/db/mdr/rules/schematron/rule-sets'

let $transform := doc('/db/mdr/rules/schematron/xslt/skeleton1-5.xsl')

let $params := doc('/db/mdr/rules/schematron/xslt/params.xml')
let $file-path := concat($ruleset-collection-path, '/', $ruleset)
let $doc := doc($file-path)
let $result := transform:transform($doc, $transform, <parameters/>)

return
<results>
        <input-file-name>{$ruleset}</input-file-name>
        <input-rule-file>{$doc}</input-rule-file>
       <output-file>{$result}</output-file>
</results>