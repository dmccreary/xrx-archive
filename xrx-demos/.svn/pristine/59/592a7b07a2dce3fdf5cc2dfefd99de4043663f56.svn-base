xquery version "1.0";
import module namespace style = "http://nuemeta.com/style" at "../../../modules/style.xqm";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";

(: compile-rule.xq Compile a Schematron rule-set file :)

let $app-collection := $style:db-path-to-app
let $input-collection := concat($style:db-path-to-app, '/data/input')
let $compiled-collection := concat($style:db-path-to-app, '/data/compiled')
let $xslt-collection := concat($style:db-path-to-app, '/xslt')

(: three stage XSLT pipeline :)
let $xslt-file1 := 'iso_dsdl_include.xsl'
let $xslt-file2 := 'iso_abstract_expand.xsl'
let $xslt-file3 := 'iso_svrl_for_xslt1.xsl'

let $xslt1 := doc(concat($xslt-collection, '/', $xslt-file1))
let $xslt2 := doc(concat($xslt-collection, '/', $xslt-file2))
let $xslt3 := doc(concat($xslt-collection, '/', $xslt-file3))

let $ruleset-collection-path := concat($style:db-path-to-app, '/rule-sets')

let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
    if (not($id)) then 
        <error>
            <message>Parameter 'id' is missing.  This is a required parameter.</message>
        </error>
    else

let $title := concat('Schematron Compilation Results for ', $id)
(: not currently being used :)
let $params := doc(concat($xslt-collection, '/', 'params.xml'))

let $file-path := concat($ruleset-collection-path, '/', $id)

let $input-doc := doc($file-path)

let $result1 := transform:transform($input-doc, $xslt1, <parameters/>)

let $result2 := transform:transform($result1, $xslt2, <parameters/>)

let $result3 := transform:transform($result2, $xslt3, <parameters/>)
(:
let $login := xmldb:login($compiled-collection, 'admin', 'admin123')
let $store := xmldb:store($compiled-collection, $id, $result3)
:)
let $content :=
<div class="content">
     <b>Input file:</b> ruleset {$id}:<br/>
       Input Rule: {count(doc(concat($input-collection, '/', $id))//node() )}
       Result node count: {count(doc(concat($compiled-collection, '/', $id))//node() )}<br/>
        <p>The ruleset {$id} has compiled without errors.   (: count($result3/*) :)</p>
</div>

return
    style:assemble-page($title, $content)