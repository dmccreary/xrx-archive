xquery version "1.0";
declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace request="http://exist-db.org/xquery/request";
declare  namespace system = "http://exist-db.org/xquery/system";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

import module namespace cms = "http://cms.metadata.thrivent.com" at "/db/mdr/cms/cms-module.xq";

declare option exist:serialize "method=html media-type=text/html indent=yes";

let $program-name := 'update.xq'

(: this will get the path to this xquery for getting related files in the format:
xmldb:exist://embedded-eXist-server/db/... :)

let $data-collection := '/db/mdr/patterns/eip/data'
let $mod-path := system:get-module-load-path()
let $base := substring-before($mod-path, $program-name)

(: this logs you in :)
let $login := xmldb:collection($data-collection, 'mdr', 'mdr123')

(: the data we want to update is in the posted data :)
let $my-doc := request:get-data()
let $id := $my-doc/id/text()
let $pattern-name := $my-doc/PatternName/text()

let $file-name := concat($data-collection, '/', $id, '.xml')

(: todo - move the original file to an archive :)
let $store-return-status := xmldb:store($data-collection, $file-name, $my-doc)

return
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Pattern Edit Update Confirmation</title>
      {cms:import-css()}
    </head>
    <body>
        {cms:header()}
    <h2>Your pattern &quot;{$pattern-name}&quot; id={$id} has been updated.</h2>
    <a href="edit?new=true">Create another pattern</a><br/>
    <a href="../views/view-pattern.xq?name={$pattern-name}">View this pattern</a><br/>
    <a href="../index.xhtml">Pattern manager main menu</a>
    </body>
</html>