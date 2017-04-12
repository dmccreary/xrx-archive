xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $program-name := 'update.xq'

(: this will get the path to this xquery for getting related files in the format:
xmldb:exist://embedded-eXist-server/db/... :)

let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection , '/data')

(: this logs you in :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: the data we want to update is in the posted data :)
let $my-doc := request:get-data()
let $id := $my-doc/DataElementName/text()
let $file-name := concat($data-collection, '/', $id, '.xml')

(: todo - move the original file to an archive :)
let $store-return-status := xmldb:store($data-collection, $file-name, $my-doc)

return
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Data Element Update Confirmation</title>
        {style:import-css()}
    </head>
    <body>
    {style:header()}
    {style:breadcrumb()}
    &gt; <a href="../views/list-items.xq">List Data Elements</a> 
    &gt; <a href="edit.xq?new=true">New</a>
    <br/>
    <h2>The Data Element &quot;{$id}&quot; has been updated.</h2>
    
    <a href="../views/view-item.xq?id={$id}">View saved Data Element</a><br/>
    {style:footer()}
    </body>
</html>