xquery version "1.0";

(: Update Item - this program repaces all the bookinfo data with the content of the post :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $incomming-data := request:get-data()

(: get the id out of the posted document :)
let $id := request:get-parameter('id', '')

return
(: check for required parameters :)
    if (not($id)) then 
        <error>
            <message>Parameter "id" is missing.  This URL parameter is required for an update operation.</message>
        </error>
    else
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

let $title := concat('Update Book Information Confirmation for document =', $id)
let $file-path := concat($data-collection, '/', $id)
let $doc := doc($file-path)/*
 
(: this saves the new file and overwrites the old one :)
let $update := update replace $doc//bookinfo with $incomming-data

let $content := 
    <div>
        <p>Item {$id} has been updated.</p>
        
        <a href="../views/view-item.xq?id={$id}" title="View {$id}">View Document {$id}</a><br/>br/>
        
        <div class="edit-controls">
            <a href="../edit/edit.xq?id={$id}" title="Edit {$id}">Edit</a>
            <a href="../edit/delete-confirm.xq?id={$id}" title="Delete {$id}">Delete</a>
            
            <a href="../edit/get-instance.xq?id={$id}" title="View XML {$id}">View XML</a>
        </div>
    </div>
    
return style:assemble-page($title, $content)