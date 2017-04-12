xquery version "1.0";
module namespace svg-demo = "http://danmccreary.com/svg-demo";

import module namespace style='http://danmccreary.com/style' at '../../../modules/style.xqm';

declare function svg-demo:assemble-page($id as xs:integer, $content as node()?, $force-flash as xs:string?, $jquery as xs:string?) as node() {
let $demo := doc(concat($style:db-path-to-app-data, '/', $id, '.xml'))/svg-demo
let $title := $demo//name/text()

(: todo, create a sequence of ids and find the current ID in this sequence.  Then get the next id. :)
let $max-id := max(for $i in collection($style:db-path-to-app-data)/svg-demo/id/text() return number($i))

return
 (
    util:declare-option('exist:serialize', 'method=xhtml media-type=text/html indent=yes')
    ,
<html>
    <head>
        
        {if ($force-flash = 'true') then <meta name="svg.render.forceflash" content="{$force-flash}" /> else ()}
        
        { style:css('xhtml') }
        
        {if ($jquery = 'true')
           then 
           (
           <link type="text/css" href="{$style:jquery}/css/custom-theme/jquery-ui-1.8.9.custom.css" rel="stylesheet" />,
           <script type="text/javascript" src="{$style:jquery}/js/jquery-1.4.4.min.js"></script>,
           <script type="text/javascript" src="{$style:jquery}/js/jquery-ui-1.8.9.custom.min.js"></script>
           )
        else ()
        }

        <script src="../../../resources/js/svgweb/svg.js" data-path="../../../resources/js/svgweb/"/>
    </head>
    <body>
    <div class="container span-24 last">

    {style:header()}

    <div class="prev-next">
        {if ($id gt 1) then <a class="button prev" href="view-item.xq?id={$id - 1}">Previous Example</a> else () }
        {if ($id lt $max-id) then <a class="button next"href="view-item.xq?id={$id + 1}">Next Example</a> else ()}
   </div>
        <h1>{$title}</h1>
        
        <style type="text/css">
            {$demo//style/text()}
        </style>
        
        {if ($demo//script-src)
           then <script type="text/javascript" src="../data/{$demo//script-src/text()}"></script>
           else ()
        }
        
        <script type="text/javascript">
            {$demo//script/text()}
        </script>
        
        <script type="image/svg+xml" xmlns:xlink="www.w3.org/1999/xlink">
            {$demo//svg}
        </script>
        
        <div class="content">
        {$demo//content/*}
        
        
        

        {$content (: the content of the unit test file :)}
     
        </div>
        
        {style:footer()}
        </div>
    </body>
</html>
)
};
