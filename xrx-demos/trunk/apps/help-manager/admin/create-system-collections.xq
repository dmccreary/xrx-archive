xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../../modules/util2.xqm";

let $title := 'Create System Configuration Collections for Lucene Fulltext Search Indexing'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

(: this path starts with '/db/' :)
let $dp-path := substring-after($data-collection, 'xmldb:exist://')
let $path-to-config := concat(request:get-context-path(), '/rest/db/system/config', $dp-path, '/collection.xconf')

let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: copy the configuration file to the system config collection :)
let $config-source-collection := $dp-path
let $config-target-collection := concat('/db/system/config', $config-source-collection)

let $mkdirs := util2:mkdirs($config-target-collection)

let $content :=
<div class="content">
    <h4>System Configuration Collections Status</h4>
    
    Checking Path = {$config-target-collection}
    <ol>
    {for $check in $mkdirs//check
       return
          <li>{$check/path/text()} {' '} {$check/status/text()}</li>
     }
    <a href="../index.xq">Directory Home</a>
    </ol>
</div>

return
    style:assemble-page($title, $content)
