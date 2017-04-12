xquery version "1.0";
declare namespace xrx="http://code.google.com/p/xrx";
(: Update Item :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data

(: TODO - check to see if we have admin privileges :)
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)

let $login := xmldb:login('/db', 'admin', 'admin123')

let $item := request:get-data()

(: get the app id out of the incoming POST :)
let $id := $item//xrx:app-id/text()
let $collection-path := concat($style:db-path-to-site, '/apps/', $id)
let $file := 'app-info.xml'
let $file-path := concat($collection-path, '/', $file)

let $title := concat('Update Confirmation for item ', $id)
let $file := concat($id, '.xml') 
 
(: this saves the new file and overwrites the old one :)
let $store := xmldb:store($collection-path, 'app-info.xml', $item)
let $doc := doc($file-path)/xrx:app-info

let $update := update value $doc//last-modified-by with xmldb:get-current-user()
let $update := update value $doc//last-modified-datetime with current-dateTime()

let $content := 
    <div>
        <p>The app-info.xml file for {$id} has been updated.</p>
        <br/>
        {style:edit-controls($id, 'evpx')}
    </div>
    
return style:assemble-page($title, $content)