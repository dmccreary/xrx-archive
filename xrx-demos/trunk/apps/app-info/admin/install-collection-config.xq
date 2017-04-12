xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Copy Collection Configuration File to System Area'

let $path-to-admin := concat(substring-after($style:db-path-to-app, 'xmldb:exist://'), '/admin')
let $path-to-data-collection := substring-after($style:db-path-to-app-data, 'xmldb:exist://')
let $target-collection := concat('/db/system/config', $path-to-data-collection)

let $resource := 'collection.xconf'

let $source-path := concat($path-to-admin, '/', $resource)

return
   if ( not(doc-available($source-path)) )
   then 
      <error>
         <message>Collection configuration document not found at {$source-path}</message>
      </error>
    else

   if ( not(xmldb:collection-available($target-collection)) )
   then 
      <error>
         <message>No system collection found at {$target-collection}</message>
      </error>
    else
    
let $login := xmldb:login($target-collection, 'admin', 'admin123')
let $copy := xmldb:copy($path-to-admin, $target-collection, $resource)

let $content :=
<div class="content">
   The configuration file has been copied to <a href="{request:get-context-path()}/rest/{$target-collection}">{$target-collection}</a>.
</div>

return style:assemble-page($title, $content)
