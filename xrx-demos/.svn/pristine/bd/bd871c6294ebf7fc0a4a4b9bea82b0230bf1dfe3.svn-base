xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Reindex Collection'
let $data-collection := $style:db-path-to-app-data
let $config-file-path := concat('/rest/db/system/config', $style:web-path-to-app, '/data/collection.xconf')

let $login := xmldb:login($data-collection, 'admin', 'admin123')
let $start-time := util:system-time()

(: Note that you can not use the exist prefix notation with this path.  This is a bug in the reindex function. :)
let $reindex := xmldb:reindex('/db/org/ucsb/apps/email/data')
let $runtime-ms := ((util:system-time() - $start-time) div xs:dayTimeDuration('PT1S'))  * 1000 

let $content :=
<div class="content">
   <h1>Reindex</h1>
   <p>The index for {$data-collection} was updated in {$runtime-ms} milliseconds.</p>
   
   <a href="{$config-file-path}">View Configuration File</a>
   <br/>
   <a href="../index.xq">App Home</a>
</div>

return style:assemble-page($title, $content)