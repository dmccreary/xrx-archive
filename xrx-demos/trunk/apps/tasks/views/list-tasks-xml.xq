xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare option exist:serialize "method=xml media-type=text/xml indent=yes";
let $collection-path := '/db/dma/apps/tasks/data'
return
<tasks>{
         for $task in collection($collection-path)/task
         return $task
}</tasks>
