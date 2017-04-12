xquery version "1.0";
import module namespace style = "http://www.danmccreary.com/library" at "../../../modules/style.xqm";

let $title := 'Language Codes'
let $app-collection := $style:db-path-to-app
let $file-path := concat($app-collection, '/import-codes/language-codes.html')

let $rows := doc($file-path)//tr
let $content :=
<code-table>
<code-table-name>language-2-type-code</code-table-name>
<items>
{
    for $row in $rows[td][string-length(td[2]/text()) = 2]
        return
        <item>
           <label>{$row/td[3]/text()}</label>
           <value>{$row/td[2]/text()}</value>
        </item>
}
</items>
</code-table>

return $content