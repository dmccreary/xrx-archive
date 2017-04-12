xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

let $title := 'Reindex XML Schema names'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: copy the configuration file to the system config collection :)
let $config-source-collection := '/db/surescripts/apps/schemas/search'
let $config-target-collection := '/db/system/config/db/surescripts/apps/schemas/data'

let $check-collection-exists1 :=
   if (xmldb:collection-available('/db/system/config/db'))
      then ()
      else xmldb:create-collection('/db/system/config', 'db')

let $check-collection-exists2 :=
   if (xmldb:collection-available('/db/system/config/db/surescripts'))
      then ()
      else xmldb:create-collection('/db/system/config/db', 'surescripts')

let $check-collection-exists3 :=
   if (xmldb:collection-available('/db/system/config/db/surescripts/apps'))
      then ()
      else xmldb:create-collection('/db/system/config/db/surescripts', 'apps')

let $check-collection-exists4 :=
   if (xmldb:collection-available('/db/system/config/db/surescripts/apps/schemas'))
      then ()
      else xmldb:create-collection('/db/system/config/db/surescripts/apps', 'schmea')
      
let $check-collection-exists5 :=
   if (xmldb:collection-available($config-target-collection))
      then ()
      else xmldb:create-collection('/db/system/config/db/surescripts/apps/schemas', 'data')
      
let $copy := xmldb:copy($config-source-collection, $config-target-collection, 'collection.xconf')

let $start-time := util:system-time()
let $reindex := xmldb:reindex($data-collection)
let $runtime-ms := ((util:system-time() - $start-time) div xs:dayTimeDuration('PT1S'))  * 1000 

let $content :=
<div class="content">
    <h1>Reindex</h1>
    <p>The index for {$data-collection} has been update in {$runtime-ms} milli-seconds.</p>
    <a href="../index.xq">Schemas Home</a>
</div>

return
    style:assemble-page($title, $content)
