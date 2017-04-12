xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../../../modules/style.xqm";

declare function local:term-callback($term as xs:string, $data as xs:int+) as element() {
   <entry>
     <term>{$term}</term>
     <frequency>{$data[1]}</frequency>
     <documents>{$data[2]}</documents>
     <position>{$data[3]}</position>
   </entry>
};



let $title := 'Reindex Directory'

let $app-collection := $style:db-path-to-app
let $data-collection := concat($app-collection, '/data')

let $login := xmldb:login($data-collection, 'admin', 'admin123')

(: copy the configuration file to the system config collection :)
let $config-source-collection := '/db/surescripts/apps/directory/search'
let $config-target-collection := '/db/system/config/db/surescripts/apps/directory/data'

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
   if (xmldb:collection-available('/db/system/config/db/surescripts/apps/directory'))
      then ()
      else xmldb:create-collection('/db/system/config/db/surescripts/apps', 'directory')
      
let $check-collection-exists5 :=
   if (xmldb:collection-available($config-target-collection))
      then ()
      else xmldb:create-collection('/db/system/config/db/surescripts/apps/directory', 'data')
      
let $copy := xmldb:copy($config-source-collection, $config-target-collection, 'collection.xconf')

let $start-time := util:system-time()
let $reindex := xmldb:reindex($data-collection)
let $runtime-ms := ((util:system-time() - $start-time) div xs:dayTimeDuration('PT1S'))  * 1000 

let $content :=
<div class="content">
    <h1>Reindex</h1>
    <p>The index for {$data-collection} has been update in {$runtime-ms} milli-seconds.</p>
    
    {util:index-keys(//EmployeeName, "A", util:function(xs:QName("local:term-callback"), 2), 1000)}
    <a href="../index.xq">Directory Home</a>
</div>

return
    style:assemble-page($title, $content)
