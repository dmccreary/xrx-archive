xquery version "1.0";

import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";
(: document namespaces declarations :)
declare namespace xrx="http://code.google.com/p/xrx";

let $title := 'XRX Demo Applications'

(: by default we will use the classified view :)
let $view-code := request:get-parameter('view-code', 'icons')

(: by default we will sort by the application name :)
let $sort := request:get-parameter('sort', 'app-name')
let $debug := xs:boolean(request:get-parameter('debug', false()))

(: if you do not install this in /db/org/library you must change this line :)
let $install-base-collection := $style:web-path-to-site
let $apps-base := concat($install-base-collection, '/apps')
let $image-base := concat($install-base-collection, '/resources/images')



(: by default we will sort by the application name :)
let $sort := request:get-parameter('sort', 'app-name')
let $debug := xs:boolean(request:get-parameter('debug', false()))

(: you can change the number of images per row but the default is five :)
let $images-per-row := xs:positiveInteger(request:get-parameter('images-per-row', 5))


let $apps :=
    for $app in collection('/db/dma/apps')//xrx:app-info
    order by $app/xrx:app-id
         return $app
      
let $app-count := count($apps)

let $apps-info-file := concat($apps-base, '/apps-info.xml')

(: get a list of all the classifiers :)
let $classifiers := 
   for $classifier in $apps//xrx:classifier
   return
      if (string-length($classifier) > 1)
         then $classifier
         else ()

let $distinct-classifiers := distinct-values($classifiers)

let $content := 
    <div class="content">

        mode={$view-code} Change View:
        <a href="?view-code=classified">Classified</a>,
        <a href="?view-code=icons">Icons</a>,
        <a href="?view-code=list">List</a>, or
        <a href="?view-code=details">Details</a> mode.  
        {$app-count} apps, 
        {$images-per-row} per row.

        {
        if ($view-code = 'icons') then 
            <table>{
            (: the number of rows to display in the table :)
            let $rows-count := xs:integer(ceiling($app-count div $images-per-row))
            for $row  in (1 to $rows-count)
            return
                <tr>{
                    for $col in (1 to $images-per-row)
                    let $n := ($row - 1) * $images-per-row + $col               
                    return
                        if ($n <= $app-count) then 
                            let $app := $apps[$n]
                            let $app-name := $app/xrx:app-name/text()
                            let $app-title := normalize-space($app/xrx:app-description-text/text())
                            let $app-base := concat($install-base-collection, '/apps/', $app/xrx:app-id/text())
                            let $app-home := concat($app-base, '/index.xq')
                            let $custom-image:= $app/xrx:app-icon-path/text()
                            
                            (: look for an application specific icon or use a site-wide default application icon. :)
                            let $image :=
                                if (string-length($custom-image) > 0) then 
                                    concat($app-base, '/', $custom-image)
                                else 
                                    concat($style:context, '/rest', $image-base, '/app-icon.png')
                            return
                                <td align="center" class="app" style="text-align: center;">
                                    <a href="{$style:context}/rest{$app-home}" title="{$app-title}">
                                        <img src="{$style:context}/rest{$image}" height="60px" width="60px"/>
                                        <br/>
                                        <span class="app-name">{$app-name}</span>
                                    </a>
                                    {if ($debug) then ($app/xrx:app-id/text()) else ()}
                                    {if ($debug) then ($app/xrx:main-menu-order/text()) else ()}
                                </td>
                        else 
                            <td/>
                }</tr>
            }</table>

        else if ($view-code = 'list') then 
            <div class="app-list">{
                for $app in $apps
                let $app-name := $app/xrx:app-name/text()
                let $app-base := concat($apps-base, '/', $app/xrx:app-id/text())
                let $app-home := concat($app-base, '/')
                return
                    <div>
                        <a href="{$app-home}/index.xq">{$app-name}</a>
                        - {util:collection-name($app)}
                        - {util:document-name($app)}
                    </div>
            }</div>

        else if ($view-code = 'details') then 
            <table class="details">
                <thead>
                    <tr>
                        <th>App Name</th>
                        <th>Description</th>
                        <th>Version</th>
                    </tr>
                </thead>
                {
                for $app in $apps
                let $app-name := $app/xrx:app-name/text()
                let $app-base := concat($apps-base, '/', $app/xrx:app-id/text())
                let $app-home := concat($app-base, '/')
                order by $app-name
                return
                    <tr class="details-row">
                        <td><a href="{$style:context}/rest{$app-home}index.xq">{$app/xrx:app-name/text()}</a></td>
                        <td>{$app/xrx:app-description-text/text()}</td>
                        <td>{$app/xrx:app-version-id/text()}</td>
                    </tr>
                }
            </table>

        else if ($view-code = 'classified')
            then
            <div class="apps">
                Classifiers = {count($distinct-classifiers)}
                {for $classifier in $distinct-classifiers
                let $apps-with-this-classifier :=
                    for $app in collection('/db/dma/apps')//xrx:app-info[.//xrx:classifier = $classifier]
                         order by lower-case($app/xrx:app-name/text())
                         return $app
                 let $classifier-count := count($apps-with-this-classifier)
                 let $rows-count := xs:integer(ceiling($classifier-count div $images-per-row) - 1)
                 order by $classifier
                 return
                 <div class="classified-apps">
                    <h3>{$classifier}</h3>
                    Count = {$classifier-count}
                    <table>{
                    (: the number of rows to display in the table :)
                    
                    for $row  in (0 to $rows-count)
                    return
                        <tr>{
                            let $classifier-row-apps := subsequence($apps-with-this-classifier, ($row * $images-per-row) + 1, $images-per-row)
                            for $col in (1 to $images-per-row)
                                let $app := $classifier-row-apps[$col]
                                let $app-name := $app/xrx:app-name/text()
                                let $app-base := concat($style:web-path-to-site, '/apps/', $app/xrx:app-id/text())
                                let $app-home := concat($app-base, '/')
                                let $custom-image:= $app/xrx:app-icon-path/text()
                                
                                let $image :=
                                    if (string-length($custom-image) > 0 and util:binary-doc-available(concat('/db/dma/apps/', $app/xrx:app-id, '/', $custom-image))) then 
                                        concat('/rest', $app-base, '/', $custom-image)
                                    else 
                                        concat('/rest', $style:web-path-to-site, '/resources/images/default-app-icon.jpg')
                                return
                                    <td class="app" width="100px" align="center">{if ($app) then
                                        <a href="{$app-home}" alt="{$app/xrx:app-name/text()}" title="{$app/xrx:app-description-text/text()}">
                                        <img class="app-icon" src="{$image}" height="60px" />
                                        <br/><div class="app-title">{$app/xrx:app-name/text()}</div></a>
                                        else ()}
                                    </td>
                        }</tr>
                    }</table>
                    </div>
                    }
             </div>

        else ('Error: Unknown View Mode.  Must be classifed, list, icons or details.')
        }

    </div>
return
    style:assemble-page($title, $content)
