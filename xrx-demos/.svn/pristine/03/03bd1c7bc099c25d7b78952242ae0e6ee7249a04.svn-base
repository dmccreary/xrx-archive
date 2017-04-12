xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "/db/mdr/modules/style.xqm";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
 
(: save-new.xq :)
let $app-collection := style:app-base-uri()
let $data-collection := concat($app-collection , '/data')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $item := request:get-data()

(: this logs you into the collection :)
let $login := xmldb:login($app-collection, 'admin', 'admin123')

(: we use the data element name for the id :)
(: TODO we need to check for dups here ...:)
let $id := $item/DataElementName/text()

(: use this as an arugment for for store command :)
let $file-name := concat($id, '.xml')

(: this creates the new file with a still-empty id element :)
let $store := xmldb:store($data-collection, $file-name, $item)

return
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Save Confirmation</title>
        <link rel="stylesheet" type="text/css" href="../../resources/css/thrivent.css"/>
    </head>
    <body>
        {style:header()}
        {style:breadcrumb()}
        <h1>New data element &quot;{$id}&quot; has been saved.</h1>
        <a href="edit.xq?new=true">Create another new data element</a><br/>
        <a href="../views/view-data-element.xq?id={$id}">View saved data element</a><br/>
        <a href="../views/data-elements.xq">List data elements</a><br/>
        {style:footer()}
    </body>
</html>
