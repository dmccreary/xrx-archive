xquery version "1.0";

(: Delete Item Confirmation :)

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
declare namespace kert = "http://kuberam.ro/ns/kert";
declare default element namespace "http://kuberam.ro/ns/kert";

let $id := request:get-parameter("id", "")

let $data-collection := $style:db-path-to-app-data
let $item := collection($data-collection)//kert:test[@id = $id]

let $title :='Are you sure you want to delete this test?'

let $content := 
    <div>
        <b>Test ID: </b>{$id}<br/>
        <b>Test Name: </b>{$item/name/text()}<br/>

        <br/><br/>
        <a class="warn" href="delete.xq?id={$id}">Yes - Delete This Test</a>
        <br/><br/><br/>
        <a class="cancel" href="../views/view-item.xq?id={$id}">Cancel (Back to View item)</a>
        <br/><br/><br/>
    </div>
    
return 
    style:assemble-page($ title, $content)