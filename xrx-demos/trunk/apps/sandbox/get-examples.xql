xquery version "1.0";
import module namespace style = "http://xmlopenfoundation.org/style" at "../../modules/style.xqm";

declare option exist:serialize "media-type=text/xml omit-xml-declaration=yes";

let $id := request:get-parameter("id", '1')
let $queries := collection('/db/org/northwestern/apps/sandbox/data')/*[id = $id][1]

return
<select id="saved" name="saved">
    <option value=""></option>
    {
    for $entry in $queries//query
    return
        <option value="{$entry/code}">{$entry/description}</option>
    }
</select>