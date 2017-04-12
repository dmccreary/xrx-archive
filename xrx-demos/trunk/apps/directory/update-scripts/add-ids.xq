xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Person Directory Listing'

let $data-collection := $style:db-path-to-app-data

let $persons := collection($data-collection)//person[not(id)]

let $content :=
<div class="content">
    Updating = {count($persons)} Records<br/>
    {
    for $person at $count in $persons
    let $update := update insert <id>{$count}</id> preceding $person/Extension
    return
    <div>Adding ID {$count} to person record {$person/EmployeeName/text()}
    </div>
}</div>

return style:assemble-page($title, $content)