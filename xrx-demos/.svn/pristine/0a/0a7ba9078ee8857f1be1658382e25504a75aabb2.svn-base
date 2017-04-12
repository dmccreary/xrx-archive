xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare namespace xf="http://www.w3.org/2002/xforms";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";
declare namespace xhtml="http://www.w3.org/1999/xhtml";


import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/xml indent=yes";

let $program-name := 'update.xq'
let $title :="Update Confirmation"
(: this will get the path to this xquery for getting related files in the format:
xmldb:exist://embedded-eXist-server/db/... :)

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')

let $mod-path := system:get-module-load-path()
let $base := substring-before($mod-path, $program-name)

(: this logs you in :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: the data we want to update is in the posted data :)
let $my-doc := request:get-data()
let $filename := $my-doc/filename/text()

(: todo - move the original file to an archive :)
let $store-return-status := xmldb:store($data-collection, $filename, $my-doc)

let $content :=
<div class="content">
    <h2>Your RuleSet filename={$filename} has been updated.</h2>
    <div class="edit-controls">
         <a href="../views/list-rule-sets.xq">View All RuleSets</a><br/>
         <a href="edit?new=true">Create Another RuleSet</a><br/>
         <a href="../views/view-single-rule-sets.xq?filename={$filename}">View this ruleset</a><br/>
         <a href="../index.xhtml"> Main Menu</a>
    </div>
</div>
    
return style:app-pages($title, $content)
  