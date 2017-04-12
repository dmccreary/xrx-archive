xquery version "1.0";

(: Update place :)

import module namespace style = "http://style.syntactica.com/us-state-hist" at "../../../modules/style.xqm";
 
let $data-collection := $style:db-path-to-app-data
let $file := concat($data-collection, '/glossary.xml')
 
(: this is where the form "POSTS" documents to this XQuery using the POST method of a submission :)
let $term := request:get-data()
 
(: this logs you into the collection :)
let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: get the id out of the posted document :)
let $id := string($term/id/text())
 
(: this saves the new view and replaces the old one :)
let $store := update replace doc($file)/terms/term[$id=id] with $term
let $update := update value doc($file)/terms/term[$id=id]/last-modified-datetime/text() with current-dateTime()

let $content := 
    <div>
        <p>Term {$id} has been updated.</p>
        <div class="edit-controls">
            <a href="../edit/edit?id={$id}" title="Edit {$id}">Edit</a>
            <a href="../edit/delete-confirm?id={$id}" title="Delete {$id}">Delete</a>
            <a href="get-instance.xq?id={$id}" title="View XML for {$id}">View XML</a>
        </div>
    </div>
    
return style:assemble-page($content)