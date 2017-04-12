xquery version "1.0";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $data-collection := '/db/org/northwestern/apps/tei/data'

let $login := xmldb:login($data-collection, 'admin', 'spe2lunk')
let $start-time := util:system-time()
let $reindex := xmldb:reindex($data-collection)
let $runtime-ms := ((util:system-time() - $start-time) div xs:dayTimeDuration('PT1S'))  * 1000 

return
<html>
    <head>
        <title>Reindex</title>
    </head>
    <body>
        <h1>Reindex</h1>
        <p>The index for {$data-collection} has been update in {$runtime-ms} milli-seconds.</p>
        <a href="../index.html">App Home</a>
    </body>
</html>