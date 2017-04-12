xquery version "1.0";
import module namespace style = "http://www.danmccreary.com/library" at "../../../modules/style.xqm";

let $title := 'Language Codes'
let $app-collection := $style:db-path-to-app
let $file-path := concat($app-collection, '/import-codes/language-codes.html')

let $content := doc($file-path)//body

return style:assemble-page($title, $content)