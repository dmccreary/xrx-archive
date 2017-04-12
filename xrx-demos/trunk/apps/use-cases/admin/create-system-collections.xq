xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";
import module namespace util2 = "http://danmccreary.com/util2" at "../../../modules/util2.xqm";

let $title := 'Create System Configuration Collections for Lucene Fulltext Search Indexing'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')
let $dp-path := substring-after($style:db-path-to-app-data, 'xmldb:exist://')

let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: copy the configuration file to the system config collection :)
let $config-source-collection := '/db/dma/apps/template/search'
let $config-target-collection := '/db/system/config/db/dma/apps/template/data'

let $check-collection-exists1 :=
   if (xmldb:collection-available('/db/system/config/db'))
      then ()
      else xmldb:create-collection('/db/system/config', 'db')

let $check-collection-exists2 :=
   if (xmldb:collection-available('/db/system/config/db/dma'))
      then ()
      else xmldb:create-collection('/db/system/config/db', 'dma')

let $check-collection-exists3 :=
   if (xmldb:collection-available('/db/system/config/db/dma/apps'))
      then ()
      else xmldb:create-collection('/db/system/config/db/dma', 'apps')

let $check-collection-exists4 :=
   if (xmldb:collection-available('/db/system/config/db/dma/apps/template'))
      then ()
      else xmldb:create-collection('/db/system/config/db/dma/apps', 'template')
      
let $check-collection-exists5 :=
   if (xmldb:collection-available($config-target-collection))
      then ()
      else xmldb:create-collection('/db/system/config/db/dma/apps/template', 'data')

let $content :=
<div class="content">
    <h1>System Configuration Collections Created</h1>
    The following collections have been created:
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma">/db/system/config/db/dma</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps">/db/system/config/db/dma/apps</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps/template">/db/system/config/db/dma/apps/template</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps/template/data">/db/system/config/db/dma/apps/template/data</a><br/>
    
    <a href="../index.xq">Directory Home</a>
</div>

return
    style:assemble-page($title, $content)
