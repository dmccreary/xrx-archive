xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace sch="http://purl.oclc.org/dsdl/schematron";

(: save a new ruleset - filename: save-new.xq - change base path if this changes. :)

let $my-doc := request:get-data()

(: the base directory ULR for this XQuery :)
let $base-path := substring-before(request:get-url(), '/save-new.xq')

(: this paths must start with '/db' is used for passing to doc() :)
let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/rule-sets')

(: get the file name out of the posted document :)
let $filename := $my-doc//id/text()

(: use this for doc :)
let $new-term-file-path := concat($data-collection, '/', $filename)

let $login := xmldb:collection($data-collection, 'admin', 'admin123')

(: store the new term in the given collction :)
let $store-return-status := xmldb:store($data-collection, $filename, $my-doc)
let $title :="Save Confirmation"

let $content :=
<div class="content">

    <h4>New RuleSet has been saved. filename={$filename}.</h4>
    <br/>
    <div class="edit-controls">
        <a href="edit.xq?">Edit</a><br/>
        <a href="../views/view-ruleset.xq?id={$filename}">View</a><br/>
        <a href="../views/list-rule-sets.xq">List</a><br/>   
    </div>
      
</div>

return style:app-page($title, $content)