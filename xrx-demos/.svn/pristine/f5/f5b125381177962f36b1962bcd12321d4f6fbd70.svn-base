xquery version "1.0";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace system = "http://exist-db.org/xquery/system";
declare namespace request="http://exist-db.org/xquery/request";
import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";
declare option exist:serialize "method=html media-type=text/html indent=yes";

(: save a new task - filename: save-new.xq - change base path if this changes. :)

let $my-doc := request:get-data()

(: the base directory ULR for this XZQuery :)
let $base-path := substring-before(request:get-url(), '/save-new.xq')

(: these paths must start with '/db' are are used for passing to doc() :)
let $data-collection := '/db/mdr/patterns/eip/data'
let $next-id-file-path := '/db/mdr/patterns/eip/data/edit/next-id.xml'

let $next-id := doc($next-id-file-path)/data/next-id/text()

(: use this as an arugment for for store command :)
let $new-term-base-file-name := concat($next-id, '.xml')

(: use this for doc :)
let $new-term-file-path := concat($data-collection, '/', $new-term-base-file-name)

let $login := xmldb:collection($data-collection, 'mdr', 'mdr123')

(: store the new term in the given collction :)
let $store-return-status := xmldb:store($data-collection, $new-term-base-file-name, $my-doc)

(: increment the next-id by one for the next document :)
let $retCode1 :=  update replace doc($next-id-file-path)/data/next-id/text() with ($next-id + 1)
(: note that next-id is now the next item so the current is next-id -1 :)

(: update the ID in the new document :)
let $retCode2 :=  update replace doc($new-term-file-path)/Pattern/id with <id>{$next-id - 1}</id>

return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Save Confirmation</title>
        {cms:import-css()}
    </head>
    <body>
      {cms:header()}
    <h1>New pattern has been saved. id={$next-id - 1}.</h1>
    <a href="edit.xq?new=true">Create another pattern</a><br/>
    <a href="../views/view-pattern.xq?id={$next-id - 1}">View saved pattern</a><br/>
    <a href="../views/list-patterns.xq">List all patterns</a><br/>   
     <a href="../../index.xhtml">Metadata Registry Home</a> &gt;
     <a href="../index.xhtml">Pattern Home</a><br/>
    </body>
</html>
