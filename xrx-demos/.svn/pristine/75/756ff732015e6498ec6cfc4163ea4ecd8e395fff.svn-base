xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Create System Configuration Collections'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: copy the configuration file to the system config collection :)
let $config-source-collection := '/db/dma/apps/feedback/search'
let $config-target-collection := '/db/system/config/db/dma/apps/feedback/data'

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
   if (xmldb:collection-available('/db/system/config/db/dma/apps/feedback'))
      then ()
      else xmldb:create-collection('/db/system/config/db/dma/apps', 'feedback')
      
let $check-collection-exists5 :=
   if (xmldb:collection-available($config-target-collection))
      then ()
      else xmldb:create-collection('/db/system/config/db/dma/apps/feedback', 'data')

let $content :=
<div class="content">
    <h1>System Configuration Collections Created</h1>
    The following collections have been created:
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma">/db/system/config/db/dma</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps">/db/system/config/db/dma/apps</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps/feedback">/db/system/config/db/dma/apps/feedback</a><br/>
    
    <a href="{request:get-context-path()}/rest/db/system/config/db/dma/apps/feedback/data">/db/system/config/db/dma/apps/feedback/data</a><br/>
    
    <a href="../index.xq">Directory Home</a>
</div>

return
    style:assemble-page($title, $content)
