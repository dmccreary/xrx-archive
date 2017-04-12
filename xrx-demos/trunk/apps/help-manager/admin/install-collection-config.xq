xquery version "1.0";
import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

let $title := 'Copy Collection Configuration File to System Area'

let $app-collection := $style:db-path-to-app
let $source-collection := concat($app-collection, '/admin')
let $target-collection := '/db/system/config/db/dma/apps/help-manager/data'

let $resource := 'collection.xconf'

let $login := xmldb:login($target-collection, 'admin', 'admin123')
let $copy := xmldb:copy($source-collection, $target-collection, $resource)

let $content :=
<div class="content">
The configuration file has been copied to <a href="/rest/{$target-collection}">{$target-collection}</a>.
</div>

return style:assemble-page($title, $content)
